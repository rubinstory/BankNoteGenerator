from flask import Flask, jsonify, request
from modules.ClientManager import ClientManager

# app = Flask(__name__)

# @app.route("/")
# def hello_world():
#     return "I am a goose:)"

# @app.route("/start/<user_id>/<")
# def get_start_signal(user_id):
#     return jsonify({
#         "ok": True,

#     })

# @app.route("/stop/<user_id>")
# def get_stop_signal(user_id):
#     res = FtxClient.sell_all()
#     return jsonify({
#         "ok": True,
#         "result": res
#     })



if __name__ == "__main__":
    #app.run()
    cm = ClientManager("Pf7HJ-5WRBgzt0eS1myGPC2DQc7WVrVqwXoLGX2R", "h0skte3bRU8qsoEUFkBUX4LBnNawMcJusbyKuNIC", "goose1", "A")
    print(cm.get_symbols())
    cm.run()
