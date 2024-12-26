DELIMITER $$

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON Employees 
FOR EACH ROW
BEGIN
    IF NEW.hire_date > CURDATE() THEN -- curdate is current date. and new mean new hire data
        SIGNAL SQLSTATE '45000' -- here the singnal mean raise a error and sqlstate mean error code format then error code is 450000
        SET MESSAGE_TEXT = 'Hire date cannot be in the future'; -- eror mess show
    END IF;
END $$

DELIMITER ;

INSERT INTO Employees (first_name, last_name, role_id, hire_date, contact_number, email) VALUES
('Michael', 'Scott', 1, '2025-03-15', '123-456-7890', 'michael.scott@example.com');


DELIMITER $$

CREATE TRIGGER before_ticket_insert
BEFORE INSERT ON Tickets
FOR EACH ROW
BEGIN
    IF NEW.seat_number NOT REGEXP '^[1-9][0-9]*[A-F]$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid seat number format';
    END IF;
END $$

DELIMITER ;

INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date)
VALUES
(1, 1, '12#', '2024-12-01 10:00:00');



CREATE TABLE TicketsSummary (
    flight_id INT PRIMARY KEY,
    total_tickets INT DEFAULT 0,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

select*from TicketsSummary;

DELIMITER $$

CREATE TRIGGER after_ticket_insert
AFTER INSERT ON Tickets 
FOR EACH ROW -- trigger where activat for each row which are inserted like that
BEGIN
    INSERT INTO TicketsSummary (flight_id, total_tickets)
    VALUES (NEW.flight_id, 1) -- new use for insert and old use for delete and udate
    ON DUPLICATE KEY UPDATE total_tickets = total_tickets + 1; -- jodie duplicate key hoy tahole update korbe othoba eta kaj korbe na 
END $$

DELIMITER ;

INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date)
VALUES (1, 2, '13A', '2024-12-25 08:00:00'),
		(3, 7, '16B', '2024-12-26 10:00:00');


