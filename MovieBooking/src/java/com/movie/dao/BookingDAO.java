  package com.movie.dao;
import java.util.Set;
import java.util.HashSet;

import com.movie.model.Booking;
import com.movie.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Add a new booking with theater_id and showtime_id
    public boolean addBooking(int userId, int movieId, String seatNo, int theaterId, int showtimeId) {
        // Check if the seat is already booked for the same movie, theater, and showtime
        String checkSeatSQL = "SELECT COUNT(*) FROM bookings WHERE movie_id = ? AND seat_no = ? AND theater_id = ? AND showtime_id = ?";
        
        // Insert new booking with theater_id and showtime_id
        String insertSQL = "INSERT INTO bookings (user_id, movie_id, seat_no, booking_date, theater_id, showtime_id) "
                         + "VALUES (?, ?, ?, NOW(), ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSeatSQL);
             PreparedStatement insertStmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {

            // Check if the seat is already booked
            checkStmt.setInt(1, movieId);
            checkStmt.setString(2, seatNo);
            checkStmt.setInt(3, theaterId);
            checkStmt.setInt(4, showtimeId);
            ResultSet rs = checkStmt.executeQuery();

            System.out.println("Checking seat availability for movie_id: " + movieId + ", seat_no: " + seatNo);

            if (rs.next()) {
                int seatCount = rs.getInt(1);
                System.out.println("Seat count for movie_id " + movieId + " and seat_no " + seatNo + ": " + seatCount);
                if (seatCount > 0) {
                    System.out.println("Seat " + seatNo + " is already booked for this movie at this showtime.");
                    return false; // Seat is taken
                }
            }

            // Insert new booking if seat is available
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, movieId);
            insertStmt.setString(3, seatNo);
            insertStmt.setInt(4, theaterId);  // Set theater_id
            insertStmt.setInt(5, showtimeId); // Set showtime_id

            System.out.println("Executing insert query for user_id: " + userId + ", movie_id: " + movieId + ", seat_no: " + seatNo);

            int rowsInserted = insertStmt.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedBookingId = generatedKeys.getInt(1); // Getting the generated ID
                    System.out.println("Booking successful for seat: " + seatNo + " with booking ID: " + generatedBookingId);
                }
                return true;
            } else {
                System.out.println("Booking failed for seat: " + seatNo);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("SQLException occurred while booking seat: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("movie_id"),
                    rs.getString("seat_no"),
                    rs.getTimestamp("booking_date"),
                    rs.getInt("theater_id"),  // Get theater_id
                    rs.getInt("showtime_id")  // Get showtime_id
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get bookings by user ID
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("movie_id"),
                    rs.getString("seat_no"),
                    rs.getTimestamp("booking_date"),
                    rs.getInt("theater_id"),  // Get theater_id
                    rs.getInt("showtime_id")  // Get showtime_id
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Remove a booking by ID
    public boolean removeBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get available seats for a given movie, theater, and showtime
    public List<String> getAvailableSeats(int movieId, int theaterId, int showtimeId) {
        List<String> availableSeats = new ArrayList<>();
        
        // Example seat numbers (you can change this according to your seat layout)
        List<String> allSeats = getAllSeatsForTheater(theaterId);

        // Query to get booked seats for a given movie, showtime, and theater
        String sql = "SELECT seat_no FROM bookings WHERE movie_id = ? AND theater_id = ? AND showtime_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, movieId);
            stmt.setInt(2, theaterId);
            stmt.setInt(3, showtimeId);
            ResultSet rs = stmt.executeQuery();

            // Store booked seats in a set for quick lookup
            Set<String> bookedSeats = new HashSet<>();
            while (rs.next()) {
                bookedSeats.add(rs.getString("seat_no"));
            }

            // Add available seats to the list
            for (String seat : allSeats) {
                if (!bookedSeats.contains(seat)) {
                    availableSeats.add(seat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return availableSeats;
    }

    // Helper method to return all seats for a given theater
    private List<String> getAllSeatsForTheater(int theaterId) {
        // You should customize this method based on the actual seat configuration in your theater
        List<String> seats = new ArrayList<>();
        for (int i = 1; i <= 20; i++) {  // Example: Seats 1-20
            seats.add(String.valueOf(i));
        }
        return seats;
    }
    public boolean addMultipleBookings(int userId, int movieId, String[] seatNumbers, int theaterId, int showtimeId) {
    String sql = "INSERT INTO bookings (user_id, movie_id, seat_no, booking_date, theater_id, showtime_id) VALUES (?, ?, ?, NOW(), ?, ?)";
    try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
        for (String seat : seatNumbers) {
            stmt.setInt(1, userId);
            stmt.setInt(2, movieId);
            stmt.setString(3, seat.trim());
            stmt.setInt(4, theaterId);
            stmt.setInt(5, showtimeId);
            stmt.addBatch();
        }
        stmt.executeBatch();
        return true;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

}
