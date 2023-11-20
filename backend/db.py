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
    User Model.
    """

    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    # one to many for ticket history and payment history
    all_tickets = db.relationship("Ticket", cascade="delete")
    cornell_student = db.Column(db.Boolean, nullable=False)
    events = db.relationship(
        "Event", secondary=event_user_assoc, back_populates="attendees"
    )

    def __init__(self, **kwargs):
        """
        Initialize a User Object
        """
        self.name = kwargs.get("name", "")
        self.cornell_student = kwargs.get("cornell_student", "")

    def serialize(self):
        # ticket history is ALL tickets. Break up history into current tickets
        # and expired tickets.
        tup = self.simple_serialize_tickets()
        return {
            "id": self.id,
            "name": self.name,
            "expired tickets": tup[0],
            "current tickes": tup[1],
            "cornell_student": self.cornell_student,
            "events": [e.simple_serialize() for e in self.events],
        }

    def simple_serialize_events(self):
        return {
            "id": self.id,
            "name": self.name,
            "cornell_student": self.cornell_student,
        }

    def simple_serialize_tickets(self):
        """
        Return two lists: old_tickets and current_tickets
        """
        old_tickets = []
        new_tickets = []
        for ticket in self.all_tickets:
            if ticket.get("is_expired") == True:
                old_tickets.append(ticket)
            else:
                new_tickets.append(ticket)
        return old_tickets, new_tickets


class Event(db.Model):
    """
    Event Model
    """

    __tablename__ = "event"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    # one to many for ticket history and payment history
    time = db.Column(db.Integer, nullable=False)
    category_id = db.Column(
        db.Integer, db.ForeignKey("eventcategory.id"), nullable=False
    )
    attendees = db.relationship(
        "User", secondary=event_user_assoc, back_populates="events"
    )

    def __init__(self, **kwargs):
        """
        Initialize an Event Object
        """
        self.name = kwargs.get("name", "")
        self.time = kwargs.get("time", "")

    def serialize(self):
        """
        Serialize an Event Object
        """
        category = EventCategory.query.filter_by(id=self.category_id).first()
        return {
            "id": self.id,
            "name": self.name,
            "time": self.time,
            "category": category.simple_serialize(),
            "attendees": [a.simple_serialize() for a in self.attendees],
        }

    def simple_serialize(self):
        """
        Simple Serialize an Event Object
        """
        category = EventCategory.query.filter_by(id=self.category_id).first()
        return {
            "id": self.id,
            "name": self.name,
            "time": self.time,
            "category": category,
        }


class EventCategory(db.Model):
    """
    EventCategory Model. One even category could be "concerts," which has a one
    to many relationship with the Event model.
    """

    __tablename__ = "eventcategory"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    event_type = db.Column(db.String, nullable=False)
    all_events = db.relationship("Event", cascade="delete")

    def __init__(self, **kwargs):
        """
        Initialize an EventCategory object.
        """
        self.event_type = kwargs.get("event_type", "")

    def serialize(self):
        """
        Serialize an EventCategory object.
        """
        return {
            "id": self.id,
            "event_type": self.event_type,
            "all_events": [e.simple_serialize() for e in self.all_events],
        }

    def simple_serialize(self):
        """
        Serialize an EventCategory object without the all_events field.
        """
        return {"id": self.id, "event_type": self.event_type}


class Ticket(db.Model):
    """
    Ticket Model.
    """

    __tablename__ = "ticket"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    cost = db.Column(db.Double, nullable=False)
    sold_time = db.Column(db.Integer, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    event_id = db.Column(db.Integer, db.ForeignKey("event.id"), nullable=False)
    is_expired = db.Column(db.Boolean, nullable=False)

    def __init__(self, **kwargs):
        """
        Initialize a Ticket object.
        """
        self.event_id = kwargs.get("event_id", 0)
        self.cost = kwargs.get("cost", 0)
        self.user_id = kwargs.get("user_id", 0)
        self.sold_time = kwargs.get("sold_time", 0)
        self.is_expired = kwargs.get("is_expired", False)

    def serialize(self):
        """
        Serialize a Ticket object.
        """
        event = Event.query.filter_by(id=self.event_id).first()
        user = User.query.filter_by(id=self.user_id).first()
        return {
            "id": self.id,
            "event_id": self.event_id,
            "event": event,
            "user": user,
            "sold_time": self.sold_time,
            "cost": self.cost,
            "is_expired": self.is_expired,
        }

    def simple_serialize(self):
        """
        Serialize a Ticket object without the user or event field.
        """
        return {
            "id": self.id,
            "event_id": self.event_id,
            "sold_time": self.sold_time,
            "cost": self.cost,
            "is_expried": self.is_expired,
        }
