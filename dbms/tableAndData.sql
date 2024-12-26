CREATE DATABASE Airport;
USE Airport;


CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    iata_code VARCHAR(3) UNIQUE NOT NULL
);


CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    iata_code VARCHAR(3) UNIQUE NOT NULL
);

-- ALTER TABLE Airlines

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_id INT NOT NULL,
    origin VARCHAR(3) NOT NULL,
    destination VARCHAR(3) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id) ON DELETE CASCADE,
    FOREIGN KEY (origin) REFERENCES Airports(iata_code),
    FOREIGN KEY (destination) REFERENCES Airports(iata_code)
);


CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    passport_number VARCHAR(50) UNIQUE NOT NULL,
    nationality VARCHAR(50) NOT NULL
);

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    booking_date DATETIME NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role_id INT NOT NULL,
    hire_date DATE NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);


CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Maintenance (
    maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    employee_id INT NOT NULL,
    maintenance_date DATETIME NOT NULL,
    status_id INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES MaintenanceStatus(status_id)
);


CREATE TABLE MaintenanceStatus (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) UNIQUE NOT NULL
);


SHOW tables from Airport;


DROP DATABASE Airport;

INSERT INTO Airports (name, location, iata_code)
VALUES
('Los Angeles International', 'Los Angeles, USA', 'LAX'),
('John F. Kennedy International', 'New York, USA', 'JFK'),
('Heathrow Airport', 'London, UK', 'LHR'),
('Tokyo Haneda Airport', 'Tokyo, Japan', 'HND'),
('Dubai International Airport', 'Dubai, UAE', 'DXB'),
('Beijing Capital International', 'Beijing, China', 'PEK'),
('Sydney Kingsford Smith', 'Sydney, Australia', 'SYD'),
('Frankfurt Airport', 'Frankfurt, Germany', 'FRA'),
('Singapore Changi Airport', 'Singapore', 'SIN'),
('Charles de Gaulle Airport', 'Paris, France', 'CDG'),
('Hong Kong International', 'Hong Kong', 'HKG'),
('Amsterdam Schiphol', 'Amsterdam, Netherlands', 'AMS'),
('Toronto Pearson International', 'Toronto, Canada', 'YYZ'),
('Doha Hamad International', 'Doha, Qatar', 'DOH'),
('Istanbul Airport', 'Istanbul, Turkey', 'IST'),
('Narita International', 'Narita, Japan', 'NRT'),
('Incheon International', 'Seoul, South Korea', 'ICN'),
('Kuala Lumpur International', 'Kuala Lumpur, Malaysia', 'KUL'),
('Munich Airport', 'Munich, Germany', 'MUC'),
('Zurich Airport', 'Zurich, Switzerland', 'ZRH'),
('Barcelona El Prat', 'Barcelona, Spain', 'BCN'),
('Madrid Barajas', 'Madrid, Spain', 'MAD'),
('Rome Fiumicino', 'Rome, Italy', 'FCO'),
('Vienna International', 'Vienna, Austria', 'VIE'),
('Copenhagen Airport', 'Copenhagen, Denmark', 'CPH'),
('Brussels Airport', 'Brussels, Belgium', 'BRU'),
('Shanghai Pudong', 'Shanghai, China', 'PVG'),
('Delhi Indira Gandhi International', 'Delhi, India', 'DEL'),
('Moscow Sheremetyevo', 'Moscow, Russia', 'SVO'),
('Bangkok Suvarnabhumi', 'Bangkok, Thailand', 'BKK'),
('Cape Town International', 'Cape Town, South Africa', 'CPT'),
('Johannesburg O.R. Tambo', 'Johannesburg, South Africa', 'JNB'),
('San Francisco International', 'San Francisco, USA', 'SFO'),
('Miami International', 'Miami, USA', 'MIA'),
('Chicago O\'Hare', 'Chicago, USA', 'ORD'),
('Houston George Bush Intercontinental', 'Houston, USA', 'IAH'),
('Atlanta Hartsfield-Jackson', 'Atlanta, USA', 'ATL'),
('Denver International', 'Denver, USA', 'DEN'),
('Seattle-Tacoma International', 'Seattle, USA', 'SEA'),
('Boston Logan International', 'Boston, USA', 'BOS');

INSERT INTO Airlines (name, iata_code)
VALUES
('American Airlines', 'AA'),
('Delta Airlines', 'DL'),
('United Airlines', 'UA'),
('British Airways', 'BA'),
('Lufthansa', 'LH'),
('Air France', 'AF'),
('Emirates', 'EK'),
('Qatar Airways', 'QR'),
('Singapore Airlines', 'SQ'),
('Cathay Pacific', 'CX'),
('Qantas', 'QF'),
('Japan Airlines', 'JL'),
('Korean Air', 'KE'),
('Etihad Airways', 'EY'),
('Turkish Airlines', 'TK'),
('Swiss International Air Lines', 'LX'),
('Alitalia', 'AZ'),
('Aeroflot', 'SU'),
('China Eastern Airlines', 'MU'),
('China Southern Airlines', 'CZ'),
('IndiGo', '6E'),
('Vistara', 'UK'),
('South African Airways', 'SA'),
('Thai Airways', 'TG'),
('KLM Royal Dutch Airlines', 'KL'),
('Aeromexico', 'AM'),
('LATAM Airlines', 'LA'),
('Air Canada', 'AC'),
('Ryanair', 'FR'),
('EasyJet', 'U2'),
('Norwegian Air Shuttle', 'DY'),
('JetBlue', 'B6'),
('Alaska Airlines', 'AS'),
('Frontier Airlines', 'F9'),
('Spirit Airlines', 'NK'),
('Virgin Atlantic', 'VS'),
('Iberia', 'IB'),
('Austrian Airlines', 'OS'),
('Finnair', 'AY'),
('Scandinavian Airlines', 'SK');

INSERT INTO Flights (airline_id, origin, destination, departure_time, arrival_time)
VALUES
(1, 'LAX', 'JFK', '2024-12-25 06:00:00', '2024-12-25 14:00:00'),
(2, 'JFK', 'LHR', '2024-12-25 08:00:00', '2024-12-25 20:00:00'),
(3, 'LHR', 'HND', '2024-12-25 10:00:00', '2024-12-26 10:00:00'),
(4, 'DXB', 'SIN', '2024-12-25 18:00:00', '2024-12-26 03:00:00'),
(5, 'SIN', 'SYD', '2024-12-25 23:00:00', '2024-12-26 08:00:00'),
(6, 'SYD', 'FRA', '2024-12-26 10:00:00', '2024-12-26 20:00:00'),
(7, 'FRA', 'CDG', '2024-12-26 12:00:00', '2024-12-26 14:00:00'),
(8, 'CDG', 'AMS', '2024-12-26 16:00:00', '2024-12-26 18:00:00'),
(9, 'AMS', 'YYZ', '2024-12-26 20:00:00', '2024-12-27 04:00:00'),
(10, 'YYZ', 'DOH', '2024-12-27 06:00:00', '2024-12-27 14:00:00'),
(11, 'IST', 'NRT', '2024-12-27 09:00:00', '2024-12-28 07:00:00'),
(12, 'ICN', 'DEL', '2024-12-28 05:00:00', '2024-12-28 13:00:00'),
(13, 'FCO', 'MAD', '2024-12-28 12:00:00', '2024-12-28 14:30:00'),
(14, 'SYD', 'LAX', '2024-12-28 22:00:00', '2024-12-28 14:00:00'),
(15, 'LAX', 'HND', '2024-12-29 06:00:00', '2024-12-30 12:00:00'),
(16, 'SIN', 'ICN', '2024-12-29 08:00:00', '2024-12-29 14:00:00'),
(17, 'CPT', 'JNB', '2024-12-30 05:00:00', '2024-12-30 06:30:00'),
(18, 'DOH', 'FRA', '2024-12-30 09:00:00', '2024-12-30 16:00:00'),
(19, 'SEA', 'DEN', '2024-12-31 10:00:00', '2024-12-31 12:30:00'),
(20, 'ATL', 'MIA', '2024-12-31 07:00:00', '2024-12-31 09:30:00'),
(21, 'JFK', 'LHR', '2025-01-01 10:00:00', '2025-01-01 22:00:00'),
(22, 'HND', 'DXB', '2025-01-01 08:00:00', '2025-01-01 18:00:00'),
(23, 'FRA', 'CDG', '2025-01-01 12:00:00', '2025-01-01 14:00:00'),
(24, 'AMS', 'YYZ', '2025-01-02 06:00:00', '2025-01-02 14:00:00'),
(25, 'IST', 'NRT', '2025-01-02 08:00:00', '2025-01-02 20:00:00'),
(26, 'ICN', 'DEL', '2025-01-03 05:00:00', '2025-01-03 13:00:00'),
(27, 'SYD', 'LAX', '2025-01-03 10:00:00', '2025-01-03 18:00:00'),
(28, 'CPT', 'JNB', '2025-01-03 12:00:00', '2025-01-03 13:30:00'),
(29, 'SEA', 'DEN', '2025-01-04 10:00:00', '2025-01-04 12:30:00'),
(30, 'ATL', 'MIA', '2025-01-04 08:00:00', '2025-01-04 10:30:00'),
(31, 'LAX', 'SYD', '2025-01-05 12:00:00', '2025-01-06 10:00:00'),
(32, 'DXB', 'SIN', '2025-01-05 20:00:00', '2025-01-06 04:00:00'),
(33, 'FCO', 'MAD', '2025-01-06 09:00:00', '2025-01-06 11:30:00'),
(34, 'ICN', 'HND', '2025-01-06 10:00:00', '2025-01-06 14:00:00'),
(35, 'JNB', 'CPT', '2025-01-07 06:00:00', '2025-01-07 07:30:00'),
(36, 'FRA', 'AMS', '2025-01-07 15:00:00', '2025-01-07 17:00:00'),
(37, 'YYZ', 'DOH', '2025-01-07 18:00:00', '2025-01-08 02:00:00'),
(38, 'SIN', 'SYD', '2025-01-08 10:00:00', '2025-01-08 18:00:00'),
(39, 'ORD', 'BOS', '2025-01-08 07:00:00', '2025-01-08 11:00:00'),
(40, 'MIA', 'ATL', '2025-01-09 10:00:00', '2025-01-09 12:30:00');


INSERT INTO Passengers (first_name, last_name, date_of_birth, passport_number, nationality)
VALUES
('John', 'Smith', '1985-06-15', 'A12345678', 'USA'),
('Emma', 'Johnson', '1990-09-23', 'B98765432', 'UK'),
('Liam', 'Brown', '1995-03-10', 'C45678901', 'Canada'),
('Sophia', 'Taylor', '1992-11-28', 'D23456789', 'Australia'),
('Noah', 'Wilson', '1988-05-12', 'E56789012', 'USA'),
('Olivia', 'Martinez', '1992-09-19', 'F67890123', 'Spain'),
('James', 'Garcia', '1987-04-11', 'G78901234', 'Mexico'),
('Isabella', 'Clark', '1994-12-24', 'H89012345', 'Italy'),
('Elijah', 'Lopez', '1989-11-13', 'I90123456', 'France'),
('Charlotte', 'Adams', '1990-03-02', 'J01234567', 'South Africa'),
('Benjamin', 'Hill', '1986-01-27', 'K12345678', 'Germany'),
('Mia', 'Walker', '1993-02-09', 'L23456789', 'Singapore'),
('Lucas', 'Young', '1984-07-15', 'M34567890', 'Japan'),
('Amelia', 'King', '1991-06-10', 'N45678901', 'UK'),
('Henry', 'Scott', '1987-09-18', 'O56789012', 'Australia'),
('Sophia', 'White', '1996-12-01', 'P67890123', 'USA'),
('Ava', 'Green', '1998-03-04', 'Q78901234', 'Canada'),
('Ethan', 'Evans', '1985-11-07', 'R89012345', 'South Korea'),
('Emily', 'Wright', '1992-01-16', 'S90123456', 'China'),
('Liam', 'Perez', '1997-05-10', 'T01234567', 'India'),
('Emma', 'Carter', '1993-09-12', 'U12345678', 'Brazil'),
('Michael', 'Bell', '1988-04-25', 'V23456789', 'USA'),
('Harper', 'Harris', '1995-06-14', 'W34567890', 'UK'),
('Alexander', 'Lee', '1990-10-22', 'X45678901', 'China'),
('Isabella', 'Kim', '1986-12-30', 'Y56789012', 'Japan'),
('Oliver', 'Gray', '1989-08-19', 'Z67890123', 'Australia'),
('Sophia', 'Baker', '1992-03-28', 'A78901234', 'France'),
('Mason', 'Reed', '1984-09-15', 'B89012345', 'South Africa'),
('Ella', 'Hernandez', '1996-02-11', 'C90123456', 'Mexico'),
('Noah', 'Cruz', '1991-07-23', 'D01234567', 'Philippines'),
('Liam', 'Morgan', '1987-05-20', 'E12345678', 'Singapore'),
('Charlotte', 'Hall', '1989-10-03', 'F23456789', 'Italy'),
('Aiden', 'Rivera', '1993-11-30', 'G34567890', 'Argentina'),
('Emily', 'Torres', '1995-01-08', 'H45678901', 'Colombia'),
('Logan', 'Parker', '1986-06-02', 'I56789012', 'New Zealand'),
('Ava', 'Hughes', '1994-12-17', 'J67890123', 'Australia'),
('Ethan', 'Foster', '1988-08-05', 'K78901234', 'UK'),
('Olivia', 'Murphy', '1990-02-19', 'L89012345', 'USA');


INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date)
VALUES
(1, 1, '12A', '2024-12-01 10:00:00'),
(2, 2, '15B', '2024-12-02 12:00:00'),
(3, 3, '9C', '2024-12-03 14:00:00'),
(4, 4, '21D', '2024-12-04 16:00:00'),
(5, 5, '7E', '2024-12-05 18:00:00'),
(6, 6, '18F', '2024-12-06 20:00:00'),
(7, 7, '4A', '2024-12-07 22:00:00'),
(8, 8, '22B', '2024-12-08 23:00:00'),
(9, 9, '16C', '2024-12-09 08:00:00'),
(10, 10, '5D', '2024-12-10 10:00:00'),
(11, 11, '13E', '2024-12-11 12:00:00'),
(12, 12, '8F', '2024-12-12 14:00:00'),
(13, 13, '3A', '2024-12-13 16:00:00'),
(14, 14, '19B', '2024-12-14 18:00:00'),
(15, 15, '1C', '2024-12-15 20:00:00'),
(16, 16, '11D', '2024-12-16 22:00:00'),
(17, 17, '6A', '2024-12-17 08:00:00'),
(18, 18, '17B', '2024-12-18 10:00:00'),
(19, 19, '10C', '2024-12-19 12:00:00'),
(20, 20, '14D', '2024-12-20 14:00:00'),
(21, 21, '20A', '2024-12-21 16:00:00'),
(22, 22, '2B', '2024-12-22 18:00:00'),
(23, 23, '23C', '2024-12-23 20:00:00'),
(24, 24, '12F', '2024-12-24 22:00:00'),
(25, 25, '14A', '2024-12-25 08:00:00');


INSERT INTO Employees (first_name, last_name, role_id, hire_date, contact_number, email) VALUES
('Michael', 'Scott', 1, '2010-03-15', '123-456-7890', 'michael.scott@example.com'),
('Dwight', 'Schrute', 2, '2012-07-23', '234-567-8901', 'dwight.schrute@example.com'),
('Jim', 'Halpert', 3, '2015-05-10', '345-678-9012', 'jim.halpert@example.com'),
('Pam', 'Beesly', 4, '2018-11-12', '456-789-0123', 'pam.beesly@example.com'),
('Stanley', 'Hudson', 6, '2014-02-28', '567-890-1234', 'stanley.hudson@example.com'),
('Kelly', 'Kapoor', 9, '2017-09-15', '678-901-2345', 'kelly.kapoor@example.com'),
('Ryan', 'Howard', 10, '2019-01-10', '789-012-3456', 'ryan.howard@example.com'),
('Angela', 'Martin', 12, '2016-03-12', '890-123-4567', 'angela.martin@example.com'),
('Oscar', 'Martinez', 14, '2015-06-25', '901-234-5678', 'oscar.martinez@example.com'),
('Kevin', 'Malone', 15, '2018-10-20', '012-345-6789', 'kevin.malone@example.com'),
('Andy', 'Bernard', 16, '2013-12-30', '123-456-7891', 'andy.bernard@example.com'),
('Phyllis', 'Vance', 17, '2011-05-11', '234-567-8902', 'phyllis.vance@example.com'),
('Toby', 'Flenderson', 18, '2012-07-19', '345-678-9013', 'toby.flenderson@example.com'),
('Darryl', 'Philbin', 19, '2014-11-05', '456-789-0124', 'darryl.philbin@example.com'),
('Holly', 'Flax', 20, '2020-03-18', '567-890-1235', 'holly.flax@example.com');



INSERT INTO Roles (role_name) VALUES
('Pilot'), ('Co-Pilot'), ('Cabin Crew'), ('Ground Staff'), ('Maintenance Engineer'),
('Manager'), ('Operations Officer'), ('Customer Service'), ('Security Officer'),
('IT Support'), ('HR Specialist'), ('Flight Dispatcher'), ('Accountant'),
('Legal Advisor'), ('Marketing Specialist'), ('Cargo Handler'), ('Cleaning Staff'),
('Quality Control'), ('Safety Inspector'), ('Administrative Assistant'),
('Scheduling Coordinator'), ('Aircraft Mechanic'), ('Technical Analyst'),
('Flight Attendant'), ('Aircraft Technician'), ('Fleet Manager'),
('Inventory Specialist'), ('Crew Supervisor'), ('Emergency Response Coordinator'),
('Risk Manager'), ('Data Analyst'), ('Transport Supervisor'), ('Fuel Specialist'),
('Route Planner'), ('Weather Analyst'), ('Public Relations Officer'),
('Lounge Manager'), ('Baggage Handler'), ('Control Tower Operator'),
('Training Specialist'), ('Medical Staff');


INSERT INTO Maintenance (flight_id, employee_id, maintenance_date, status_id)
VALUES
(1, 5, '2024-12-20 08:00:00', 1),
(2, 5, '2024-12-21 10:00:00', 2),
(3, 5, '2024-12-22 12:00:00', 3),
(4, 5, '2024-12-23 14:00:00', 4),
(5, 5, '2024-12-24 16:00:00', 5),
(6, 6, '2024-12-25 10:00:00', 6),
(7, 7, '2024-12-26 12:00:00', 2),
(8, 8, '2024-12-27 14:00:00', 8),
(9, 9, '2024-12-28 16:00:00', 9),
(10, 10, '2024-12-29 18:00:00', 1),
(11, 11, '2024-12-30 10:00:00', 11),
(12, 12, '2024-12-31 12:00:00', 12),
(13, 13, '2025-01-01 14:00:00', 13),
(14, 14, '2025-01-02 16:00:00', 14),
(15, 15, '2025-01-03 18:00:00', 15);


INSERT INTO MaintenanceStatus (status_name) VALUES
('Scheduled'), ('In Progress'), ('Completed'), ('Delayed'), ('Canceled'),
('Under Review'), ('Awaiting Parts'), ('Resolved'), ('On Hold'), ('Urgent'),
('Inspection'), ('Repaired'), ('Pending Approval'), ('Partially Completed'),
('Quality Check'), ('Routine Maintenance'), ('Major Overhaul'), ('System Check'),
('Safety Assessment'), ('Technical Review');
