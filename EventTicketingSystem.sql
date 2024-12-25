#Event Ticketing System Database Schema
create database Event_Ticketing_System;
use Event_Ticketing_System;
#Table: Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

#Table: Events
CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE,
    location VARCHAR(100),
    total_tickets INT,
    available_tickets INT
);

#Table: Bookings
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    booking_date DATE,
    tickets_booked INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

#Insert Sample Data
INSERT INTO Users (name, email, phone) VALUES
('Aanish', 'aanish@example.com', '9086343245'),
('delma', 'delma@example.com', '9876543211');

INSERT INTO Events (event_name, event_date, location, total_tickets, available_tickets) VALUES
('Music', '2024-05-01', 'Auditorium A', 200, 200),
('Art', '2024-06-15', 'Auditorium B', 150, 150);

#Book Tickets
INSERT INTO Bookings (user_id, event_id, booking_date, tickets_booked)
VALUES (1, 1, '2024-01-10', 2);

UPDATE Events
SET available_tickets = available_tickets - 2
WHERE event_id = 1;

#Query: List all Users
SELECT * FROM Users;

#Query: List all Events
SELECT * FROM Events;

#Query: Events Booked by a User
SELECT e.event_name, e.event_date, e.location, b.tickets_booked, b.booking_date
FROM Bookings b
JOIN Events e ON b.event_id = e.event_id
WHERE b.user_id = 1;

#Query: Events with Available Tickets
SELECT event_name, location, available_tickets 
FROM Events WHERE available_tickets > 0;

#Query: Total Tickets Booked per User
SELECT u.name, SUM(b.tickets_booked) AS total_tickets
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
GROUP BY u.name;

#Query: String Functions Examples
#Concatenate user name and address
SELECT CONCAT(name, ' - ', email) AS user_details FROM Users;

#Extract the domain from user emails
SELECT email, SUBSTRING_INDEX(email, '@', -1) AS email_domain FROM Users;

#Convert event name to uppercase
SELECT UPPER(event_name) AS event_name_upper FROM Events;

#Get the length of the event name
SELECT event_name, LENGTH(event_name) AS event_name_length FROM Events;

#Replace spaces with underscores in event names
SELECT REPLACE(event_name, ' ', '_') AS formatted_event_name FROM Events;

#Using INDEX
CREATE INDEX idx_event_name ON Events (event_name);

#Subquery: Find the event with the highest total tickets
SELECT event_name FROM Events 
WHERE total_tickets = (SELECT MAX(total_tickets) FROM Events);

#ALTER Table: Add column for event organizer
ALTER TABLE Events ADD COLUMN organizer VARCHAR(100);

#ALTER Table: Modify location to allow longer strings
ALTER TABLE Events MODIFY COLUMN location VARCHAR(200);

#ALTER Table: Drop unused column example
ALTER TABLE Events DROP COLUMN organizer;

#WHERE Clause: Fetch Events in a Specific Location
SELECT * FROM Events WHERE location = 'Auditorium A';

#UPDATE Query: Update ticket availability
UPDATE Events
SET available_tickets = available_tickets - 1
WHERE event_id = 2;

#ORDER BY: List events by date ascending
SELECT * FROM Events ORDER BY event_date ASC;

#Stored Procedure: Add a new event
DELIMITER $$
CREATE PROCEDURE AddEvent (
    IN eventName VARCHAR(255),
    IN eventDate DATE,
    IN eventLocation VARCHAR(100),
    IN totalTickets INT
)
BEGIN
    INSERT INTO Events (event_name, event_date, location, total_tickets, available_tickets)
    VALUES (eventName, eventDate, eventLocation, totalTickets, totalTickets);
END $$
DELIMITER ;

#Trigger: Automatically Decrease Available Tickets on Booking
DELIMITER $$
CREATE TRIGGER DecreaseTickets
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Events
    SET available_tickets = available_tickets - NEW.tickets_booked
    WHERE event_id = NEW.event_id;
END $$
DELIMITER ;

#Trigger: Automatically Increase Available Tickets on Booking Cancellation
DELIMITER $$
CREATE TRIGGER IncreaseTickets
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Events
    SET available_tickets = available_tickets + OLD.tickets_booked
    WHERE event_id = OLD.event_id;
END $$
DELIMITER ;
