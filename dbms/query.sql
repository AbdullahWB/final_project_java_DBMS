SELECT * FROM airport.airlines;
SELECT * FROM airport.airports;
SELECT * FROM airport.employees;
SELECT * FROM airport.flights;
SELECT * FROM airport.maintenance;
SELECT * FROM MaintenanceStatus;
SELECT * FROM airport.passengers;
SELECT * FROM airport.tickets;
SELECT * from TicketsSummary;


SET SQL_SAFE_UPDATES = 0;
UPDATE TicketsSummary
	SET total_tickets= (
    CASE total_tickets
			WHEN total_tickets = 2 THEN 4
            WHEN total_tickets = 1 THEN 2
            	ELSE NULL
		END
    );

SELECT p.passport_number , t.seat_number
FROM passengers p
LEFT JOIN tickets t ON p.passenger_id = t.passenger_id
WHERE p.passenger_id = 1;



SELECT * FROM Airport.Flights
WHERE origin = 'SYD';

SELECT * FROM Flights
JOIN airlines ON Flights.airline_id = airlines.airline_id
WHERE airlines.name = 'Norwegian Air Shuttle';


-- simple TRIGGER
-- insert
INSERT INTO Airports (name, location, iata_code) 
	VALUES ('Chicago Midway', 'Chicago, USA', 'MDW');

INSERT INTO Airlines (name, iata_code) 
	VALUES ('Hawaiian Airlines', 'HA');

INSERT INTO Flights (airline_id, origin, destination, departure_time, arrival_time) 
	VALUES (1, 'LAX', 'ORD', '2025-01-10 08:00:00', '2025-01-10 14:00:00');

INSERT INTO Passengers (first_name, last_name, date_of_birth, passport_number, nationality) 
	VALUES ('John', 'Doe', '1990-01-01', 'P12345678', 'USA');

INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date) 
	VALUES (1, 1, '12A', '2025-01-05 12:00:00');


-- update
UPDATE Flights 
SET departure_time = '2025-01-10 10:00:00' 
WHERE flight_id = 1;

UPDATE Passengers 
SET nationality = 'Canada' 
WHERE passport_number = 'P12345678';

UPDATE Airlines 
SET iata_code = 'AA1' 
WHERE name = 'American Airlines';

UPDATE Employees 
SET role_id = 3 
WHERE employee_id = 1;


-- delete
DELETE FROM Passengers 
WHERE passport_number = 'P12345678';

DELETE FROM Airlines 
WHERE name = 'Hawaiian Airlines';


DELETE FROM Tickets 
WHERE ticket_id = 1;



SELECT MAX(total_tickets) AS top_tickets
FROM TicketsSummary;


SELECT COUNT(*) AS total_passengers 
FROM Passengers;


SELECT * FROM Flights
JOIN Maintenance ON Flights.flight_id = Maintenance.flight_id;



SELECT * FROM Employees 
WHERE hire_date > '2020-01-01';


SELECT Roles.role_name, COUNT(*) AS total_employees 
FROM Employees 
JOIN Roles ON Employees.role_id = Roles.role_id 
WHERE role_name = 'Cabin Crew';



SELECT seat_number 
FROM Tickets 
WHERE flight_id = 1;

SELECT * 
FROM Flights
WHERE departure_time = CURDATE();


SELECT passport_number, COUNT(*) AS How_much_flight_have
FROM passengers p
JOIN tickets t ON p.passenger_id = t.passenger_id
WHERE p.passenger_id = 1
GROUP BY p.passport_number;
