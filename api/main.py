from pprint import pprint
from backtest.backtest import *
from trading.binanace import *

# TEST LOGIC
bot = BinanceBot("./binance.txt")
bt = BackTesting()
df = bot.get_historical_data("XRPUSDT", "5m", "2022-12-14", "2022-01-13", 1000)
print(df)

# bot = BybitBot("./bybit.txt")
# a = bot.get_balance("XRP")
# print(a)