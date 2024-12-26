-- Transaction with TCL
START TRANSACTION;
SELECT * FROM Passengers WHERE Passenger_id = 1;
SELECT * FROM Flights WHERE Flight_id = 1;
INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date)
VALUES (1, 1, '10A', '2024-12-01 15:00:00');
COMMIT;


START TRANSACTION;
UPDATE Maintenance
SET maintenance_date = '2024-12-31 08:00:00'
WHERE maintenance_id = 1;
SAVEPOINT MaintenanceUpdate; -- save point is save data like partial commit save until final commit 
UPDATE Maintenance
SET status_id = 2
WHERE maintenance_id = 1;
COMMIT;



START TRANSACTION;
SELECT * FROM Airlines WHERE airline_id = 1;
INSERT INTO Flights (airline_id, origin, destination, departure_time, arrival_time)
VALUES (1, 'LAX', 'JFK', '2025-01-01 10:00:00', '2025-01-01 18:00:00');
COMMIT;


START TRANSACTION;
SELECT * FROM airport.flights;
DELETE FROM airport.flights WHERE flight_id = 42 ;
SELECT * FROM airport.flights;
ROLLBACK;
SELECT * FROM airport.flights;
COMMIT;



