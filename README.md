Users Table: Stores basic user information, such as user ID, name, email, and phone.

Events Table: Stores event details like event name, event date, location, total tickets, and available tickets.

Bookings Table: Relates users and events, storing booking details such as the booking date and number of tickets booked.

Insert Sample Data: Sample data for users and events, as well as a booking action for a user.

Queries:
Listing users, events, events booked by a user, and events with available tickets.

Calculating total tickets booked per user.

Using string functions like CONCAT, SUBSTRING_INDEX, UPPER, LENGTH, and REPLACE to manipulate data.

Indexing: Creating an index on event_name to speed up queries.

Subquery: Finding the event with the highest total tickets.

ALTER Table: Modifying the structure of the Events table, adding and dropping columns.

WHERE Clause: Fetching events in a specific location.

UPDATE Query: Updating ticket availability after a booking.

Ordering: Sorting events by date.

Stored Procedure: Creating a procedure to add a new event.

Triggers: Automatically adjusting the available tickets when a booking is made or canceled.
