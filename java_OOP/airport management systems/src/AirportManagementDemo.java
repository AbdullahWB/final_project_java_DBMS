import java.sql.*;
import java.util.Scanner;

// Database Connection Class
class DBConnection {
    private static Connection connection;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Database connection details
                String url = "jdbc:mysql://localhost:3306/airport";
                String username = "root"; // Your MySQL username
                String password = "Ma@892002"; // Your MySQL password

                // Establish the connection
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Database connected successfully!");

            } catch (ClassNotFoundException e) {
                System.out.println("MySQL JDBC Driver not found.");
                e.printStackTrace();
            } catch (SQLException e) {
                System.out.println("Failed to connect to the database.");
                e.printStackTrace();
            }
        }
        return connection;
    }
}

class Airport {
    private int airport_id;
    private String airport_name;
    private String airport_location;
    private String iata_code;

    public Airport(String airport_name, String airport_location, String iata_code) {
        this.airport_name = airport_name;
        this.airport_location = airport_location;
        this.iata_code = iata_code;
    }

    public int getAirport_id() {
        return airport_id;
    }

    public void setAirport_id(int airport_id) {
        this.airport_id = airport_id;
    }

    public String getAirport_name() {
        return airport_name;
    }

    public void setAirport_name(String airport_name) {
        this.airport_name = airport_name;
    }

    public String getAirport_location() {
        return airport_location;
    }

    public void setAirport_location(String airport_location) {
        this.airport_location = airport_location;
    }

    public String getIata_code() {
        return iata_code;
    }

    public void setIata_code(String iata_code) {
        this.iata_code = iata_code;
    }
}

class AirportDAO {
    public void addAirport(Airport airport) throws SQLException {
        String query = "INSERT INTO Airports (airport_name, airport_location, iata_code) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, airport.getAirport_name());
            stmt.setString(2, airport.getAirport_location());
            stmt.setString(3, airport.getIata_code());
            stmt.executeUpdate();
        }
    }

    public void listAirports() throws SQLException {
        String query = "SELECT * FROM Airports";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Name: %s, Location: %s, IATA Code: %s\n",
                        rs.getInt("airport_id"),
                        rs.getString("airport_name"),
                        rs.getString("airport_location"),
                        rs.getString("iata_code"));
            }
        }
    }
}

class Airline {
    private int airline_id;
    private String airline_name;
    private String iata_code;

    public Airline(String airline_name, String iata_code) {
        this.airline_name = airline_name;
        this.iata_code = iata_code;
    }

    public int getAirline_id() {
        return airline_id;
    }

    public void setAirline_id(int airline_id) {
        this.airline_id = airline_id;
    }

    public String getAirline_name() {
        return airline_name;
    }

    public void setAirline_name(String airline_name) {
        this.airline_name = airline_name;
    }

    public String getIata_code() {
        return iata_code;
    }

    public void setIata_code(String iata_code) {
        this.iata_code = iata_code;
    }
}

class AirlineDAO {
    public void addAirlines(Airline airline) throws SQLException {
        String query = "INSERT INTO Airlines (airline_name, iata_code) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, airline.getAirline_name());
            stmt.setString(2, airline.getIata_code());
            stmt.executeUpdate();
        }
    }

    public void listAirlines() throws SQLException {
        String query = "SELECT * FROM Airlines";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Name: %s, IATA Code: %s\n",
                        rs.getInt("airline_id"),
                        rs.getString("airline_name"),
                        rs.getString("iata_code"));
            }
        }
    }
}

class Flight {
    private int flight_id;
    private int airline_id;
    private String origin;
    private String destination;
    private String departure_time;
    private String arrival_time;

    public Flight(int airline_id, String origin, String destination, String departure_time, String arrival_time) {
        this.airline_id = airline_id;
        this.origin = origin;
        this.destination = destination;
        this.departure_time = departure_time;
        this.arrival_time = arrival_time;
    }

    public int getFlight_id() {
        return flight_id;
    }

    public void setFlight_id(int flight_id) {
        this.flight_id = flight_id;
    }

    public int getAirline_id() {
        return airline_id;
    }

    public void setAirline_id(int airline_id) {
        this.airline_id = airline_id;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getDeparture_time() {
        return departure_time;
    }

    public void setDeparture_time(String departure_time) {
        this.departure_time = departure_time;
    }

    public String getArrival_time() {
        return arrival_time;
    }

    public void setArrival_time(String arrival_time) {
        this.arrival_time = arrival_time;
    }

}

class FlightDAO {
    public void addFlight(Flight flight) throws SQLException {
        String query = "INSERT INTO Flights (airline_id, origin, destination, departure_time, arrival_time) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, flight.getAirline_id());
            stmt.setString(2, flight.getOrigin());
            stmt.setString(3, flight.getDestination());
            stmt.setString(4, flight.getDeparture_time());
            stmt.setString(5, flight.getArrival_time());
            stmt.executeUpdate();
        }
    }

    public void listFlights() throws SQLException {
        String query = "SELECT * FROM Flights";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf(
                        "ID: %d, Airline ID: %d, Origin: %s, Destination: %s, Departure Time: %s, Arrival Time: %s\n",
                        rs.getInt("flight_id"),
                        rs.getInt("airline_id"),
                        rs.getString("origin"),
                        rs.getString("destination"),
                        rs.getString("departure_time"),
                        rs.getString("arrival_time"));
            }
        }
    }
}

class Passenger {
    private int id;
    private String firstName;
    private String lastName;
    private String passportNumber;

    public Passenger(String firstName, String lastName, String passportNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.passportNumber = passportNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }
}

class PassengerDAO {
    public void addPassenger(Passenger passenger) throws SQLException {
        String query = "INSERT INTO Passengers (first_name, last_name, passport_number) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, passenger.getFirstName());
            stmt.setString(2, passenger.getLastName());
            stmt.setString(3, passenger.getPassportNumber());
            stmt.executeUpdate();
        }
    }

    public void listPassengers() throws SQLException {
        String query = "SELECT * FROM Passengers";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Name: %s %s, Passport: %s\n",
                        rs.getInt("passenger_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("passport_number"));
            }
        }
    }
}

class Ticket {
    private int ticket_id;
    private int flight_id;
    private int passenger_id;
    private String seat_number;
    private String booking_date;

    public Ticket(int flight_id, int passenger_id, String seat_number, String booking_date) {
        this.flight_id = flight_id;
        this.passenger_id = passenger_id;
        this.seat_number = seat_number;
        this.booking_date = booking_date;
    }

    public int getTicket_id() {
        return ticket_id;
    }

    public void setTicket_id(int ticket_id) {
        this.ticket_id = ticket_id;
    }

    public int getFlight_id() {
        return flight_id;
    }

    public void setFlight_id(int flight_id) {
        this.flight_id = flight_id;
    }

    public int getPassenger_id() {
        return passenger_id;
    }

    public void setPassenger_id(int passenger_id) {
        this.passenger_id = passenger_id;
    }

    public String getSeat_number() {
        return seat_number;
    }

    public void setSeat_number(String seat_number) {
        this.seat_number = seat_number;
    }

    public String getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(String booking_date) {
        this.booking_date = booking_date;
    }

}

class TicketDAO {
    public void addTicket(Ticket ticket) throws SQLException {
        String query = "INSERT INTO Tickets (flight_id, passenger_id, seat_number, booking_date) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, ticket.getFlight_id());
            stmt.setInt(2, ticket.getPassenger_id());
            stmt.setString(3, ticket.getSeat_number());
            stmt.setString(4, ticket.getBooking_date());
            stmt.executeUpdate();
        }
    }

    public void listTickets() throws SQLException {
        String query = "SELECT * FROM Tickets";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Flight ID: %d, Passenger ID: %d, Seat Number: %s, Booking Date: %s\n",
                        rs.getInt("ticket_id"),
                        rs.getInt("flight_id"),
                        rs.getInt("passenger_id"),
                        rs.getString("seat_number"),
                        rs.getString("booking_date"));
            }
        }
    }
}

class Employees {
    private int employee_id;
    private String first_name;
    private String last_name;
    private int role_id;
    private String hire_date;
    private int contact_number;
    private String email;

    public Employees(String first_name, String last_name, int role_id, String hire_date, int contact_number,
            String email) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.role_id = role_id;
        this.hire_date = hire_date;
        this.contact_number = contact_number;
        this.email = email;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getHire_date() {
        return hire_date;
    }

    public void setHire_date(String hire_date) {
        this.hire_date = hire_date;
    }

    public int getContact_number() {
        return contact_number;
    }

    public void setContact_number(int contact_number) {
        this.contact_number = contact_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}

class EmployeesDAO {
    public void addEmployee(Employees employee) throws SQLException {
        String query = "INSERT INTO Employees (first_name, last_name, role_id, hire_date, contact_number, email) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, employee.getFirst_name());
            stmt.setString(2, employee.getLast_name());
            stmt.setInt(3, employee.getRole_id());
            stmt.setString(4, employee.getHire_date());
            stmt.setInt(5, employee.getContact_number());
            stmt.setString(6, employee.getEmail());
            stmt.executeUpdate();
        }
    }

    public void listEmployees() throws SQLException {
        String query = "SELECT * FROM Employees";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf(
                        "ID: %d, Name: %s %s, Role ID: %d, Hire Date: %s, Contact Number: %d, Email: %s\n",
                        rs.getInt("employee_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getInt("role_id"),
                        rs.getString("hire_date"),
                        rs.getInt("contact_number"),
                        rs.getString("email"));
            }
        }
    }
}

class Roles {
    private int role_id;
    private String role_name;

    public Roles(String role_name) {
        this.role_name = role_name;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

}

class RolesDAO {
    public void addRole(Roles role) throws SQLException {
        String query = "INSERT INTO Roles (role_name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, role.getRole_name());
            stmt.executeUpdate();
        }
    }

    public void listRoles() throws SQLException {
        String query = "SELECT * FROM Roles";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Role Name: %s\n",
                        rs.getInt("role_id"),
                        rs.getString("role_name"));
            }
        }
    }
}

class Maintenance {
    private int maintenance_id;
    private int employee_id;
    private int flight_id;
    private String maintenance_date;
    private int status_id;

    public Maintenance(int employee_id, int flight_id, String maintenance_date, int status_id) {
        this.employee_id = employee_id;
        this.flight_id = flight_id;
        this.maintenance_date = maintenance_date;
        this.status_id = status_id;
    }

    public int getMaintenance_id() {
        return maintenance_id;
    }

    public void setMaintenance_id(int maintenance_id) {
        this.maintenance_id = maintenance_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public int getFlight_id() {
        return flight_id;
    }

    public void setFlight_id(int flight_id) {
        this.flight_id = flight_id;
    }

    public String getMaintenance_date() {
        return maintenance_date;
    }

    public void setMaintenance_date(String maintenance_date) {
        this.maintenance_date = maintenance_date;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

}

class MaintenanceDAO {
    public void addMaintenance(Maintenance maintenance) throws SQLException {
        String query = "INSERT INTO Maintenance (employee_id, flight_id, maintenance_date, status_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maintenance.getEmployee_id());
            stmt.setInt(2, maintenance.getFlight_id());
            stmt.setString(3, maintenance.getMaintenance_date());
            stmt.setInt(4, maintenance.getStatus_id());
            stmt.executeUpdate();
        }
    }

    public void listMaintenance() throws SQLException {
        String query = "SELECT * FROM Maintenance";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf(
                        "ID: %d, Employee ID: %d, Flight ID: %d, Maintenance Date: %s, Status ID: %d\n",
                        rs.getInt("maintenance_id"),
                        rs.getInt("employee_id"),
                        rs.getInt("flight_id"),
                        rs.getString("maintenance_date"),
                        rs.getInt("status_id"));
            }
        }
    }
}

class MaintenanceStatus {
    private int status_id;
    private String status_name;

    public MaintenanceStatus(String status_name) {
        this.status_name = status_name;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public String getStatus_name() {
        return status_name;
    }

    public void setStatus_name(String status_name) {
        this.status_name = status_name;
    }

}

class MaintenanceStatusDAO {
    public void addStatus(MaintenanceStatus status) throws SQLException {
        String query = "INSERT INTO MaintenanceStatus (status_name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status.getStatus_name());
            stmt.executeUpdate();
        }
    }

    public void listStatus() throws SQLException {
        String query = "SELECT * FROM MaintenanceStatus";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.printf("ID: %d, Status Name: %s\n",
                        rs.getInt("status_id"),
                        rs.getString("status_name"));
            }
        }
    }
}

public class AirportManagementDemo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        AirportDAO airportDAO = new AirportDAO();
        AirlineDAO airlineDAO = new AirlineDAO();
        FlightDAO flightDAO = new FlightDAO();
        PassengerDAO passengerDAO = new PassengerDAO();
        TicketDAO ticketDAO = new TicketDAO();
        EmployeesDAO employeesDAO = new EmployeesDAO();

        while (true) {
            System.out.println("\nAirport Management System");
            System.out.println("1. Manage Airports");
            System.out.println("2. Manage Airlines");
            System.out.println("3. Manage Flights");
            System.out.println("4. Manage Passengers");
            System.out.println("5. Manage Tickets");
            System.out.println("6. Manage Employees");
            System.out.println("7. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    manageAirports(scanner, airportDAO);
                    break;
                case 2:
                    manageAirlines(scanner, airlineDAO);
                    break;
                case 3:
                    manageFlights(scanner, flightDAO);
                    break;
                case 4:
                    managePassengers(scanner, passengerDAO);
                    break;
                case 5:
                    manageTickets(scanner, ticketDAO);
                    break;
                case 6:
                    manageEmployees(scanner, employeesDAO);
                    break;
                case 7:
                    System.out.println("Exiting the system. Goodbye!");
                    scanner.close();
                    System.exit(0);
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void manageAirports(Scanner scanner, AirportDAO airportDAO) {
        while (true) {
            System.out.println("\nManage Airports");
            System.out.println("1. Add Airport");
            System.out.println("2. List Airports");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter Airport Name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter Airport Location: ");
                    String location = scanner.nextLine();
                    System.out.print("Enter IATA Code: ");
                    String iataCode = scanner.nextLine();

                    Airport airport = new Airport(name, location, iataCode);
                    try {
                        airportDAO.addAirport(airport);
                        System.out.println("Airport added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding airport: " + e.getMessage());
                    }
                    break;
                case 2:
                    try {
                        airportDAO.listAirports();
                    } catch (SQLException e) {
                        System.err.println("Error listing airports: " + e.getMessage());
                    }
                    break;
                case 3:
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void manageAirlines(Scanner scanner, AirlineDAO airlineDAO) {
        while (true) {
            System.out.println("\nManage Airlines");
            System.out.println("1. Add Airline");
            System.out.println("2. List Airlines");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter Airline Name: ");
                    String airlineName = scanner.nextLine();
                    System.out.print("Enter IATA Code: ");
                    String iataCode = scanner.nextLine();

                    Airline airline = new Airline(airlineName, iataCode);
                    try {
                        airlineDAO.addAirlines(airline);
                        System.out.println("Airline added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding airline: " + e.getMessage());
                    }
                    break;
                case 2:
                    try {
                        airlineDAO.listAirlines();
                    } catch (SQLException e) {
                        System.err.println("Error listing airlines: " + e.getMessage());
                    }
                    break;
                case 3:
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void managePassengers(Scanner scanner, PassengerDAO passengerDAO) {
        while (true) {
            System.out.println("\nManage Passengers");
            System.out.println("1. Add Passenger");
            System.out.println("2. List Passengers");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter First Name: ");
                    String firstName = scanner.nextLine();
                    System.out.print("Enter Last Name: ");
                    String lastName = scanner.nextLine();
                    System.out.print("Enter Passport Number: ");
                    String passportNumber = scanner.nextLine();

                    Passenger passenger = new Passenger(firstName, lastName, passportNumber);
                    try {
                        passengerDAO.addPassenger(passenger);
                        System.out.println("Passenger added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding passenger: " + e.getMessage());
                    }
                    break;

                case 2:
                    try {
                        passengerDAO.listPassengers();
                    } catch (SQLException e) {
                        System.err.println("Error listing passengers: " + e.getMessage());
                    }
                    break;

                case 3:
                    return;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void manageFlights(Scanner scanner, FlightDAO flightDAO) {
        while (true) {
            System.out.println("\nManage Flights");
            System.out.println("1. Add Flight");
            System.out.println("2. List Flights");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter Airline ID: ");
                    int airlineId = scanner.nextInt();
                    scanner.nextLine();
                    System.out.print("Enter Origin: ");
                    String origin = scanner.nextLine();
                    System.out.print("Enter Destination: ");
                    String destination = scanner.nextLine();
                    System.out.print("Enter Departure Time: ");
                    String departureTime = scanner.nextLine();
                    System.out.print("Enter Arrival Time: ");
                    String arrivalTime = scanner.nextLine();

                    Flight flight = new Flight(airlineId, origin, destination, departureTime, arrivalTime);
                    try {
                        flightDAO.addFlight(flight);
                        System.out.println("Flight added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding flight: " + e.getMessage());
                    }
                    break;

                case 2:
                    try {
                        flightDAO.listFlights();
                    } catch (SQLException e) {
                        System.err.println("Error listing flights: " + e.getMessage());
                    }
                    break;

                case 3:
                    return;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void manageTickets(Scanner scanner, TicketDAO ticketDAO) {
        while (true) {
            System.out.println("\nManage Tickets");
            System.out.println("1. Add Ticket");
            System.out.println("2. List Tickets");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter Flight ID: ");
                    int flightId = scanner.nextInt();
                    scanner.nextLine();
                    System.out.print("Enter Passenger ID: ");
                    int passengerId = scanner.nextInt();
                    scanner.nextLine();
                    System.out.print("Enter Seat Number: ");
                    String seatNumber = scanner.nextLine();
                    System.out.print("Enter Booking Date: ");
                    String bookingDate = scanner.nextLine();

                    Ticket ticket = new Ticket(flightId, passengerId, seatNumber, bookingDate);
                    try {
                        ticketDAO.addTicket(ticket);
                        System.out.println("Ticket added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding ticket: " + e.getMessage());
                    }
                    break;

                case 2:
                    try {
                        ticketDAO.listTickets();
                    } catch (SQLException e) {
                        System.err.println("Error listing tickets: " + e.getMessage());
                    }
                    break;

                case 3:
                    return;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void manageEmployees(Scanner scanner, EmployeesDAO employeesDAO) {
        while (true) {
            System.out.println("\nManage Employees");
            System.out.println("1. Add Employee");
            System.out.println("2. List Employees");
            System.out.println("3. Back");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter First Name: ");
                    String firstName = scanner.nextLine();
                    System.out.print("Enter Last Name: ");
                    String lastName = scanner.nextLine();
                    System.out.print("Enter Role ID: ");
                    int roleId = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    System.out.print("Enter Hire Date: ");
                    String hireDate = scanner.nextLine();
                    System.out.print("Enter Contact Number: ");
                    int contactNumber = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    System.out.print("Enter Email: ");
                    String email = scanner.nextLine();

                    Employees employee = new Employees(firstName, lastName, roleId, hireDate, contactNumber, email);
                    try {
                        employeesDAO.addEmployee(employee);
                        System.out.println("Employee added successfully!");
                    } catch (SQLException e) {
                        System.err.println("Error adding employee: " + e.getMessage());
                    }
                    break;

                case 2:
                    try {
                        employeesDAO.listEmployees();
                    } catch (SQLException e) {
                        System.err.println("Error listing employees: " + e.getMessage());
                    }
                    break;

                case 3:
                    return;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

}
