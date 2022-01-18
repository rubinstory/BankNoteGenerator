import time
from datetime import datetime
from pprint import pprint
from apscheduler.schedulers.background import BackgroundScheduler
import pandas as pd
from indicator.BB import get_bollinger_band
from ftx import FtxClient

class SqueezeBounce:
    def __init__(self, client, symbols) -> None:
        self.client = client
        self.symbols = symbols[0]
        self.current = 0.0
        self.BB = {}
        self.prev = {}
        self.current = 0.0
        self.awaiting_long = False
        self.awaiting_short = False
    

    def get_historical_dataframe(self, ticker, interval, limit):
        # get data from binance api
        raw = self.client.get_historical_data(ticker, interval, limit)
        
        # generate dataframe
        df = pd.DataFrame(raw)
        df = df.drop(["startTime", "volume"], axis=1).apply(pd.to_numeric)

        # time formatting
        df['time'] = df['time'].map(lambda it : datetime.fromtimestamp(it/1000.0))

        # set index name as tag
        df.index.name = ticker

        return df

    def make_order(self):
        try:
            if self.awaiting_long:
                self.buy_long(10)
            if self.awaiting_short:
                self.buy_short(10)
        except Exception as e:
            print(e)

    
    def buy_long(self, amount):
        print(f"=={self.symbol} 롱 진입 여부 체크==")
        if self.current > self.BB["lower"]:
            print("True\n")
            # Basic Order
            self.client.place_order(
                market=self.symbol, 
                side="buy",
                price=None,
                type="market",
                size=amount/self.get_current_price()
                ) 

            order = self.client.get_order_history()[0]
            
            # TP/SL
            price = order["avgFillPrice"]
            range = price - self.prev["low"]
            target = price + range
            stop = price - range

            print(f"==진입 가격: {price}==")
            self.client.place_conditional_order(
                    market=self.symbol,
                    side="sell",
                    trigger_price= stop,
                    size=order["size"],
                    type="stop",
                    reduce_only=True
                )
            self.client.place_conditional_order(
                    market=self.symbol,
                    side="sell",
                    trigger_price= target,
                    size=order["size"],
                    type="take_profit",
                    reduce_only=True
                )
            
            self.awaiting_long = False
            print(f"=={self.symbol} 롱 진입 완료==")
        else:
            print("False\n")
        
        
    def buy_short(self, amount):
        print(f"=={self.symbol} 숏 진입 여부 체크==")
        if self.current < self.BB["upper"]:
            print("True\n")
            # Basic Order
            self.client.place_order(
                market=self.symbol, 
                side="sell",
                price=None,
                type="market",
                size=amount/self.get_current_price()
                ) 

            order = self.client.get_order_history()[0]
            
            # TP/SL
            price = order["avgFillPrice"]
            range = self.prev["high"] - price
            target = price - range
            stop = price + range

            print(f"==진입 가격: {price}==")
            print(order)
            self.client.place_conditional_order(
                    market=self.symbol,
                    side="buy",
                    trigger_price= stop,
                    size=order["size"],
                    type="stop",
                    reduce_only=True
                )
            self.client.place_conditional_order(
                    market=self.symbol,
                    side="buy",
                    trigger_price= target,
                    size=order["size"],
                    type="take_profit",
                    reduce_only=True
                )
            
            self.awaiting_short = False
            
            print(f"=={self.symbol} 숏 진입 완료==")

        else:
            print("False\n")

    def log(self):
        print("=====직전 캔들의 정보====")
        print(f"시각: {datetime.fromtimestamp(self.prev['time']/1000.0)}")
        print(f"시가: {self.prev['open']}")
        print(f"고가: {self.prev['high']}")
        print(f"저가: {self.prev['low']}")
        print(f"종가: {self.prev['close']}")
        print(f"볼밴 하단: {self.BB['prev_lower']}, 볼밴 상단: {self.BB['prev_upper']}")
        print("=====최신 업데이트====")
        print(f"타겟 코인: {self.symbol}")
        print(f"현재 시각: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"현재가: {self.current}")
        print(f"볼밴 하단: {self.BB['lower']}, 볼밴 상단: {self.BB['upper']}")
        print("-----------------------------\n")

    def check_cond(self):
        # For Long Condition
        if self.prev['close'] < self.BB["prev_lower"]:
            self.awaiting_long = True
            print(f"** {self.symbol} 롱 대기중... **")
        
        # For Short Condition
        if self.prev['close'] > self.BB["prev_upper"]:
            self.awaiting_short = True
            print(f"** {self.symbol} 숏 대기중... **")

    def get_current_price(self):
        self.current = self.client.get_market(self.symbol)["price"]
        return self.current
      
    def get_previous_ohlc(self):
        self.prev = self.client.get_historical_data(self.symbol, 300, 2)[0]
        
    def update_bb(self):
        df = self.get_historical_dataframe(self.symbol, 300, 21)
        BB = get_bollinger_band(df, 20, 2)
        self.BB = {
            "upper": BB["ubb"].values[-1],
            "lower": BB["lbb"].values[-1],
            "prev_upper": BB["ubb"].values[-2],
            "prev_lower": BB["lbb"].values[-2]
        }
    
    def update(self):
        print("===")
        try:
            # Awaiting for updating
            time.sleep(3)
            # Get current price
            self.get_current_price()
            # Get prev
            self.get_previous_ohlc()
            # Upadte Bollinger Band
            self.update_bb()
            # Log
            self.log()
            # Check for entry
            self.check_cond()
            # Make orders
            self.make_order()
        except Exception as e:
            print(e)
