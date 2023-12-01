import json

from db import db
from db import User

from db import Ticket
from db import Event
from flask import Flask, request

app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# your routes here


# -- USER ROUTES ------------------------------------------------------
@app.route("/")

# get user by id
@app.route("/api/users/<int:user_id>/", methods=["GET"])
def get_user(user_id):
    """
    Endpoint for getting a user by id.
    """
    pass


# -- EVENT ROUTES ------------------------------------------------------
# get all events
@app.route("/api/events/", methods=["GET"])
def get_events():
    pass


# get events by search, case insensitive
@app.route("/api/events/", methods=["GET"])
def get_events_by_search():
    pass


# -- TICKET ROUTES ------------------------------------------------------


# sell ticket
@app.route("/api/tickets/<int:ticket_id>/", methods=["POST"])
def sell_ticket(ticket_id):
    pass


# buy ticket
@app.route("/api/tickets/<int:ticket_id>/", methods=["POST"])
def buy_ticket(ticket_id):
    pass


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
