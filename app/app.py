#!/usr/bin/env python3

from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hellu Vurld. Zees is zee-a vebsite-a fur CS373 IDB Pruject. Bork Bork Bork!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
