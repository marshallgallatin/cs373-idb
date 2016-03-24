#!/usr/bin/env python3

from flask import Flask
app = Flask(__name__)

@app.route("/")
def splash():
    return app.send_static_file('html/splash.html')

@app.route("/<path:path>")
def static_html(path):
    return app.send_static_file('html/{}'.format(path))

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
