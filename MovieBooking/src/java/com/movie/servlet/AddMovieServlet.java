package com.movie.servlet;

import com.movie.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AddMovieServlet")
public class AddMovieServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddMovieServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String durationStr = request.getParameter("duration");
        String ratingStr = request.getParameter("rating");
        String imageUrl = request.getParameter("image_url");

        // Validate required fields
        if (title == null || title.trim().isEmpty() ||
            genre == null || genre.trim().isEmpty() ||
            durationStr == null || durationStr.trim().isEmpty()) {
            response.sendRedirect("error.jsp?msg=All fields except rating and image are required");
            return;
        }

        int duration;
        double rating = 0;
        try {
            duration = Integer.parseInt(durationStr);
            if (ratingStr != null && !ratingStr.isEmpty()) {
                rating = Double.parseDouble(ratingStr);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?msg=Invalid number format");
            return;
        }

        // Set default image if not provided
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = "images/default-movie.png";  // Change this to your default image path
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(
                 "INSERT INTO movies (title, genre, duration, rating, image_url) VALUES (?, ?, ?, ?, ?)")) {

            stmt.setString(1, title);
            stmt.setString(2, genre);
            stmt.setInt(3, duration);
            stmt.setDouble(4, rating);  // No need to check for `null`, default is `0.0`
            stmt.setString(5, imageUrl);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("admin-dashboard.jsp?msg=Movie added successfully");
            } else {
                response.sendRedirect("error.jsp?msg=Failed to add movie");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while adding movie", e);
            response.sendRedirect("error.jsp?msg=Database error. Please try again later.");
        }
    }
}
