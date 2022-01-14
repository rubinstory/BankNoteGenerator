import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import talib as ta

pd.set_option('display.max_rows', None)

class BackTesting:
    def __init__(self) -> None:
        self.FEE = 0.002
    
    def test_vbs(self, df):
        for k in np.arange(0.1, 1, 0.1):
            total = self.get_ror_vbs(df, k).cumprod()[-2]
            mdd = self.get_mdd(df)
            print(f"{k:0.1f} - TOTAL: {total}, MDD: {mdd}")

    def get_ror_vbs(self, df, k): #day-trading
        df["range"] = (df["high"] - df["low"]) * k
        df["target"] = df["open"] + df["range"].shift(1)
        df["ror"] = np.where((df["high"] > df["target"]) , df["close"]/df["target"] - self.FEE, 1)
            
        return df["ror"]
    
    def test_bb(self, df):
        calculated = self.get_ror_bb(df)
        calculated['cum'] = calculated['ror'].cumprod()
        
        print(f"{calculated}\n\n----------------")
        print(f"CAGR: {self.get_cagr(calculated['cum'][-1])}%, MDD: {self.get_mdd(calculated)}%")

        plt.plot(calculated['cum'])
        plt.title(calculated.index.name)
        plt.show()
    
    def get_ror_bb(self, df): #scalping
        # bollinger band
        ubb, mbb, lbb = ta.BBANDS(df["close"], 20, 2)
        df["ubb"] = ubb
        df["lbb"] = lbb

        # check for conditions
        df["long_awaiting"] = df['close'] < df['lbb']
        df["short_awaiting"] = df['close'] > df['ubb']

        df["long_pos"] = ~df["long_awaiting"] & df['long_awaiting'].shift(1)
        df["short_pos"] = ~df["short_awaiting"] & df['short_awaiting'].shift(1)

        # entry price
        df.loc[ df["long_pos"] == True, "entry"] = df["close"]
        df.loc[ df["short_pos"] == True, "entry"] = df["close"]

        # swing high & swing low
        df["swing_low"] = np.where(df["low"].shift(1) >= df["low"], df["low"], df["low"].shift(1))
        df["swing_high"] = np.where(df["high"].shift(1) <= df["high"], df["high"], df["high"].shift(1))

        # calculating range
        df.loc[ df["long_pos"] == True, "range"] = df["close"] - df["swing_low"]
        df.loc[ df["short_pos"] == True, "range"] = df["swing_high"] - df["close"]

        # target profit & stop loss
        df.loc[ df["long_pos"] == True, "tp"] = df["entry"] + df["range"]
        df.loc[ df["long_pos"] == True, "sl"] = df["entry"] - df["range"]
        df.loc[ df["short_pos"] == True, "tp"] = df["entry"] - df["range"]
        df.loc[ df["short_pos"] == True, "sl"] = df["entry"] + df["range"]

        # calculating profits
        df["ror"] = 1.0

        long = df[df.long_pos == True]
        short = df[df.short_pos == True]

        long_loss = []
        for i in long.index:
            for low in df["low"][i+1:]:
                if df["sl"][i] >= low:
                    df["ror"][i] = (df["sl"][i] / df["entry"][i]) - self.FEE
                    long_loss.append(i)
                    break

        long_profit = list(set(long.index).difference(long_loss))
        for i in long_profit:
            for high in df["high"][i+1:]:
                if df["tp"][i] <= high:
                    df["ror"][i] = (df["tp"][i] / df["entry"][i]) - self.FEE
                    break

        short_loss = []
        for i in short.index:
            for high in df["high"][i+1:]:
                if df["sl"][i] <= high:
                    df["ror"][i] = (df["entry"][i] / df["sl"][i]) - self.FEE
                    short_loss.append(i)
                    break
        
        short_profit = list(set(short.index).difference(short_loss))
        for i in short_profit:
            for low in df["low"][i+1:]:
                if df["tp"][i] >= low:
                    df["ror"][i] = (df["entry"][i] / df["tp"][i]) - self.FEE
                    break
        return df
    
    def get_cagr(self, total, period):
        year = period/365
        return round((total ** (1/year)-1) * 100, 2)

    def get_mdd(self, df):
        df["hpr"] = df["ror"].cumprod()
        df["dd"] = (df["hpr"].cummax() - df["hpr"]) / df['hpr'].cummax() * 100
        return df["dd"].max()
    
    def is_bull_market(self, df, period): #check bull market in short term
        df["ma"] = df["close"].rolling(period).mean().shift(1)
        return df["open"] > df["ma"]