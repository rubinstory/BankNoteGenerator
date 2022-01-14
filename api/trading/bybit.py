import time
from datetime import datetime
from pprint import pprint
import pandas as pd
from pybit import HTTP

class BybitBot:
    def __init__(self, filename) -> None:
        with open(filename) as f:
            lines = f.readlines()
            api_key = lines[0].strip()
            api_secret = lines[1].strip()
        
        self.__session = HTTP(
            endpoint="https://api.bybit.com",
            api_key=api_key,
            api_secret=api_secret
        )
    
    def get_tickers(self): 
        symbols = self.__session.query_symbol()
        return symbols['result']

    def get_balance(self, ticker):
        balances = self.__session.get_wallet_balance()['result']
        return balances[ticker]
