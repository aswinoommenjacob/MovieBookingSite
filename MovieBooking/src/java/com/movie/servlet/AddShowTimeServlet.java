package com.movie.servlet;

import com.movie.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

@WebServlet("/AddShowTimeServlet")
public class AddShowTimeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the parameters from the request
        String movieIdStr = request.getParameter("movieId");
        String theaterIdStr = request.getParameter("theaterId");
        String showTimeStr = request.getParameter("showTime");

        // Debugging: Print the parameters to check if they are coming through correctly
        System.out.println("Received parameters:");
        System.out.println("movieIdStr: " + movieIdStr);
        System.out.println("theaterIdStr: " + theaterIdStr);
        System.out.println("showTimeStr: " + showTimeStr);

        // Validate the parameters
        if (movieIdStr == null || movieIdStr.trim().isEmpty() || theaterIdStr == null || theaterIdStr.trim().isEmpty() || showTimeStr == null || showTimeStr.trim().isEmpty()) {
            String errorMessage = "All fields are required";
            response.sendRedirect("admin-dashboard.jsp?msg=" + URLEncoder.encode(errorMessage, "UTF-8"));
            return;
        }

        try {
            // Fix the showTimeStr format to match the Timestamp format
            showTimeStr = showTimeStr.replace("T", " "); // Replaces T with a space (necessary for Timestamp format)

            // Ensure that the showTimeStr has a valid format for Timestamp (yyyy-MM-dd HH:mm:ss)
            if (showTimeStr.length() == 16) { // Format is yyyy-MM-dd HH:mm
                showTimeStr += ":00"; // Add seconds as "00"
            }

            // Parse the parameters
            int movieId = Integer.parseInt(movieIdStr);
            int theaterId = Integer.parseInt(theaterIdStr);
            Timestamp showTime = Timestamp.valueOf(showTimeStr); // Now the format is correct for Timestamp

            // Get a connection to the database
            Connection conn = DBConnection.getConnection();

            // Check if the connection is valid
            if (conn == null) {
                String errorMessage = "Database connection error";
                response.sendRedirect("admin-dashboard.jsp?msg=" + URLEncoder.encode(errorMessage, "UTF-8"));
                return;
            }

            // SQL query to insert the showtime
            String sql = "INSERT INTO movie_theater (movie_id, theater_id, show_time) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set the values for the query
            stmt.setInt(1, movieId);
            stmt.setInt(2, theaterId);
            stmt.setTimestamp(3, showTime);

            // Execute the update
            int rowsAffected = stmt.executeUpdate();

            // Close resources in the finally block
            stmt.close();
            conn.close();

            // Check if the insertion was successful
            if (rowsAffected > 0) {
                String successMessage = "Showtime added successfully";
                response.sendRedirect("admin-dashboard.jsp?msg=" + URLEncoder.encode(successMessage, "UTF-8"));
            } else {
                String errorMessage = "Error adding showtime";
                response.sendRedirect("admin-dashboard.jsp?msg=" + URLEncoder.encode(errorMessage, "UTF-8"));
            }

        } catch (Exception e) {
            // Catch and handle exceptions (e.g., SQLException, NumberFormatException, etc.)
            e.printStackTrace();
            String errorMessage = "Error adding showtime: " + e.getMessage();
            response.sendRedirect("admin-dashboard.jsp?msg=" + URLEncoder.encode(errorMessage, "UTF-8"));
        }
    }
}
