import logging
import sys
from time import timezone
from flask import Flask, jsonify, request
from modules.ClientManager import ClientManager
from apscheduler.schedulers.background import BackgroundScheduler
from strategies.SqueezeBounce import SqueezeBounce

def please(user_name, user_type, api_key, api_secret):
    print("asas")
    cm = ClientManager(
        user_name,
        user_type,
        api_key,
        api_secret
    )

    if cm.check_balance(10):
            cm.set_leverage()
            s = SqueezeBounce(cm.client ,cm.get_symbols())
            s.update()
            return True
    else:
        print("잔고 부족!!")
        return False


sched = BackgroundScheduler(daemon=True, timezone="Asia/Seoul")
sched.start()

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "I am a goose:)"

@app.route("/start", methods=["POST"])
def get_start_signal():
    body = request.get_json()

    sched.add_job(
        please,
         'cron',
          hour='0-23',
          minute='*/5',
           args=[body["user_name"],
            body["user_type"],
            body["api_key"],
            body["api_secret"],]
           )

    return jsonify({
        "ok": True
    })

@app.route("/stop", methods=["POST"])
def get_stop_signal():
    return jsonify({
        "ok": True,
    })



if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)

