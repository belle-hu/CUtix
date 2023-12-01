import json

from backend.src.db import db
from backend.src.db import User

from backend.src.db import Ticket
from backend.src.db import Event
from flask import Flask, request

app = Flask(__name__)
db_filename = "cutix.db"

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
@app.route("/api/users/", methods=["POST"])
def create_user():
    """
    Endpoint for creating a new user.
    """
    body = json.loads(request.data)
    input_name = body.get("name")
    input_netid = body.get("netid")
    if input_name is None or input_netid is None:
        return failure_response("Missing name or netid!", 400)
    new_user = User(name=body.get("name"), holding_tickets=[], netid=body.get("netid"))
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)


@app.route("/api/users/<int:user_id>/", methods=["GET"])
def get_user(user_id):
    """
    Endpoint for getting a user by id.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    return success_response(user.serialize())


# -- EVENT ROUTES ------------------------------------------------------


@app.route("/api/events/", methods=["POST"])
def create_event():
    """
    Endpoint for creating a new event.
    """
    body = json.loads(request.data)
    input_name = body.get("name")
    input_time = body.get("time")
    input_category = body.get("category")
    input_location = body.get("location")
    if (
        input_name is None
        or input_time is None
        or input_category is None
        or input_location is None
    ):
        return failure_response("Missing event field!", 400)
    new_event = Event(
        name=input_name,
        time=input_time,
        category=input_category,
        location=input_location,
    )
    db.session.add(new_event)
    db.session.commit()
    return success_response(new_event.simple_serialize(), 201)


@app.route("/api/events/", methods=["GET"])
def get_events():
    """
    Endpoint for getting all events.
    """
    events = [event.simple_serialize() for event in Event.query.all()]
    return success_response({"Events": events})


@app.route("/api/event/search/", methods=["GET"])
def get_events_by_search():
    """
    Endpoint for getting events by search, case-insensitive.
    """
    body = json.loads(request.data)
    # initialize task
    name = body.get("name")
    if name == None:
        return failure_response("Missing name in request", 400)
    case_insn_events = get_case_insn_events(name)
    # Cornell cOrNell
    # missing_char_events = get_missing_char_events(name)
    space_insn_events = get_space_events(name)
    # Cornell c O r N
    all_events = {
        "case insensitive equal events": case_insn_events,
        "space insensitive equal events": space_insn_events,
    }
    return success_response(all_events)


def get_case_insn_events(name):
    valid_events = []
    for event in Event.query.all():
        nam = event.name
        if nam.casefold() == name.casefold():
            valid_events.append(event.simple_serialize())
    return valid_events


def get_space_events(name):
    valid_events = []
    for event in Event.query.all():
        nam_strip = event.name.replace(" ", "")
        name_strip = name.replace(" ", "")
        if nam_strip.casefold() == name_strip.casefold():
            valid_events.append(event.simple_serialize())
    return valid_events


# -- TICKET ROUTES ------------------------------------------------------
@app.route("/api/tickets/", methods=["POST"])
def create_ticket():
    """
    Endpoint for creating a new ticket.
    """
    body = json.loads(request.data)
    input_cost = body.get("cost")
    input_holder_id = body.get("holder_id")
    input_is_selling = body.get("is_selling")
    input_event_id = body.get("event_id")
    if (
        input_cost is None
        or input_holder_id is None
        or input_is_selling is None
        or input_event_id is None
    ):
        return failure_response("Missing event field!", 400)
    new_ticket = Ticket(
        cost=input_cost,
        holder_id=input_holder_id,
        is_selling=input_is_selling,
        event_id=input_event_id,
    )
    db.session.add(new_ticket)
    db.session.commit()
    return success_response(new_ticket.serialize(), 201)


@app.route("/api/tickets/<int:ticket_id>/", methods=["POST"])
def sell_ticket(ticket_id):
    ticket = Ticket.query.filter_by(id=ticket_id).first()
    if ticket is None:
        return failure_response("Ticket not found")
    ticket.is_selling = True
    db.session.commit()
    return success_response(ticket.serialize(), 201)


@app.route("/api/tickets/buy/<int:ticket_id>/", methods=["POST"])
def buy_ticket(ticket_id):
    """
    Endpoint for buying a ticket.
    """
    ticket = Ticket.query.filter_by(id=ticket_id).first()
    if ticket is None:
        return failure_response("Ticket not found!")
    body = json.loads(request.data)
    buyer_id = body.get("buyer_id")
    if buyer_id is None:
        return failure_response("Missing buyer_id!", 400)
    if ticket.is_selling:
        ticket.holder_id = buyer_id
        db.session.commit()
    return success_response(ticket.serialize(), 201)
    # return original ticket if ticket is NOT being sold


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
