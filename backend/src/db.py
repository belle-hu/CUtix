from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


event_user_assoc = db.Table(
    "event_user_assoc",
    db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("user.id")),
    db.Column("event_id", db.Integer, db.ForeignKey("event.id")),
)


class User(db.Model):
    """
    User Model
    """

    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    # one to many for ticket history and payment history
    holding_tickets = db.relationship("Ticket", cascade="delete")
    netid = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        """
        Initialize a User Object
        """
        self.name = kwargs.get("name", "")
        self.netid = kwargs.get("netid", "")

    def serialize(self):
        # ticket history is ALL tickets. Break up history into current tickets
        # and expired tickets.
        return {
            "id": self.id,
            "name": self.name,
            "holding tickets": [
                h.simple_serialize_holder() for h in self.holding_tickets
            ],
            "netid": self.netid,
        }

    def simple_serialize(self):
        """
        Simple seriliaze User object without holding_tickets field.
        """
        return {
            "id": self.id,
            "name": self.name,
            "netid": self.netid,
        }


class Event(db.Model):
    """
    Event Model
    """

    __tablename__ = "event"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    # one to many for ticket history and payment history
    time = db.Column(db.String, nullable=False)  # still need to decide on this
    category = db.Column(db.String, nullable=False)
    location = db.Column(db.String, nullable=False)
    tickets = db.relationship("Ticket", cascade="delete")

    def __init__(self, **kwargs):
        """
        Initialize an Event Object
        """
        self.name = kwargs.get("name", "")
        self.time = kwargs.get("time", "")
        self.location = kwargs.get("location", "")
        self.category = kwargs.get("category", "")

    def serialize(self):
        """
        Serialize an Event Object
        """
        return {
            "id": self.id,
            "name": self.name,
            "time": self.time,
            "category": self.category,
            "location": self.location,
            "tickets": [t.simple_serialize_event() for t in self.tickets],
        }

    def simple_serialize(self):
        """
        Simple serialize an Event Object without the tickets field.
        """
        return {
            "id": self.id,
            "name": self.name,
            "time": self.time,
            "category": self.category,
            "location": self.location,
        }


class Ticket(db.Model):
    """
    Ticket Model.
    """

    __tablename__ = "ticket"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    cost = db.Column(db.Integer, nullable=False)
    holder_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=True)
    event_id = db.Column(db.Integer, db.ForeignKey("event.id"), nullable=False)
    is_selling = db.Column(db.Boolean, nullable=False)

    def __init__(self, **kwargs):
        """
        Initialize a Ticket object.
        """
        self.event_id = kwargs.get("event_id", 0)
        self.cost = kwargs.get("cost", 0)
        self.holder_id = kwargs.get("holder_id", None)
        self.is_selling = kwargs.get("is_expired", False)

    def serialize(self):
        """
        Serialize a Ticket object.
        """
        event = Event.query.filter_by(id=self.event_id).first()
        holder = User.query.filter_by(id=self.holder_id).first()
        return {
            "id": self.id,
            "event": event.simple_serialize(),
            "holder": holder.simple_serialize(),
            "cost": self.cost,
            "is_selling": self.is_selling,
        }

    def simple_serialize_holder(self):
        """
        Serialize a Ticket object without the holder field.
        """
        event = Event.query.filter_by(id=self.event_id).first()
        return {
            "id": self.id,
            "event": event.simple_serialize(),
            "cost": self.cost,
            "is_selling": self.is_selling,
        }

    def simple_serialize_event(self):
        """
        Serialize a Ticket object without the holder field.
        """
        holder = Event.query.filter_by(id=self.holder_id).first()
        return {
            "id": self.id,
            "holder": holder.simple_serialize,
            "cost": self.cost,
            "is_selling": self.is_selling,
        }
