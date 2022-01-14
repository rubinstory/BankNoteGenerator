import time
from datetime import datetime
from pprint import pprint
import pandas as pd
from binance.client import Client

class BinanceBot:
    def __init__(self, filename) -> None:
        with open(filename) as f:
            lines = f.readlines()
            api_key = lines[0].strip()
            api_secret = lines[1].strip()

        self.__client = Client(api_key, api_secret)

    def get_tickers(self):
        tickers = self.__client.get_all_tickers()

        df = pd.DataFrame(tickers)
        df.set_index("symbol", inplace=True)
        return df

    def get_balance(self, ticker):
        balance = self.__client.get_asset_balance(asset=ticker)
        return balance

    def show_price_per_sec(self, ticker):
        while True:
            coin = self.__client.get_symbol_ticker(symbol=ticker)
            print(datetime.datetime.now(), coin['price'])
            time.sleep(1)

    def get_futures_price(self, ticker):
        price = self.__client.futures_symbol_ticker(symbol=ticker)
        return price

    def get_historical_data(self, ticker, interval, start, end, limit):
        # get data from binance api
        raw = self.__client.get_historical_klines(
            symbol=ticker,
            interval=interval,
            start_str=start,
            end_str=end,
            limit=limit
        )
        
        # extract necessary info
        data_ohlc = []
        for i in raw:
            data_ohlc.append(i[0:7])
        
        # generate dataframe
        col_ohlc = ["open_time", "open", "high", "low", "close", "volume", "close_time"]
        df = pd.DataFrame(data_ohlc, columns=col_ohlc).apply(pd.to_numeric).drop("volume", axis=1)

        # time formatting
        df['open_time'] = df['open_time'].map(lambda it : datetime.fromtimestamp(it/1000.0))
        df['close_time'] = df['close_time'].map(lambda it : datetime.fromtimestamp(it/1000.0))

        # set index name as tag
        df.index.name = ticker

        return df

    def trade(client):
        while True:
            #현재가 조회
            #볼밴 조회
            #만약 (종가 < 볼밴하단):
            #    매수준비 on
            #    대기..
            #    만약 종가 > 볼밴하단:
            #       롱 포지션 시장가 진입
            #       이때, 손절가 = 시그널 캔들의 저가
            #price = client.futures_symbol_ticker("ADA")["price"]
            #ubb, mbb, lbb = ta.BBANDS(df["close"], 20, 2)
            time.sleep(1)
