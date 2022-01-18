from apscheduler.schedulers.background import BackgroundScheduler
from ftx import FtxClient

from strategies.SqueezeBounce import SqueezeBounce

class ClientManager:
    def __init__(self, user_name, user_type, api_key, api_secret) -> None:        
        self.client = FtxClient(api_key=api_key, api_secret=api_secret)
        self.user_name = user_name
        self.user_type = user_type

    def get_balance_with(self, fiat):
        try:
            for balance in self.client.get_balances():
                if balance["coin"] == fiat:
                    return balance["availableWithoutBorrow"]
            return 0
        except:    
            for balance in self.client.get_subaccounts_balance():
                if balance["coin"] == fiat:
                    return balance["availableWithoutBorrow"]
            return 0
    
    def check_balance(self, amount):
        return self.get_balance_with("USD") >= amount

    def clear_position(self):
        print(f"==포지션 종료 FOR {self.user_name}")

        response = []
        for pos in self.client.get_positions():
            if pos["openSize"] == 0.0:
                continue
            
            if pos["side"] == "sell":
                self.client.place_order(
                    market=pos["future"], 
                    side="buy",
                    price=None,
                    type="market",
                    size=pos["openSize"]
                )
            elif pos["side"] == "buy":
                self.client.place_order(
                    market=pos["future"], 
                    side="sell",
                    price=None,
                    type="market",
                    size=pos["openSize"]
                )
            response.append(f"{pos['future']}({pos['openSize']}): 시장가 {pos['side']} 주문 성공")
        return {
            "ok": True,
            "user_name": self.user_name,
            "response": response,
        }
    
    def clear_order(self):
        self.client.cancel_orders()
        return {
            "ok": True,
            "user_name": self.user_name,
        }

    def get_symbols(self):
        if self.user_type == "A": #용맹한 호랑이(x10)
            return ["SOL-PERP","LUNA-PERP","ATOM-PERP","SAND-PERP", "AXS-PERP"]
        
        elif self.user_type == "B": #날렵한 여우(x5)
            return ["DYDX-PERP", "1INCH-PERP", "XRP-PERP", "EOS-PERP"]
        
        elif self.user__type == "C" or self.user__type == "D": #현명한 부엉이(x2) or #신중한 거북이(X-1) 
            return ["BTC-PERP","ETH-PERP","XRP-PERP","EOS-PERP"]
    
    
    def set_leverage(self):
        if self.user_type == "A": #용맹한 호랑이(x10)
            self.client.set_leverage(10)
        
        elif self.user_type == "B": #날렵한 여우(x5)
            self.client.set_leverage(5)
        
        elif self.user_type == "C": #현명한 부엉이(x2) 
            self.client.set_leverage(2)
        
        elif self.user_type == "D": #신중한 거북이(X-1) 
            self.client.set_leverage(1)

