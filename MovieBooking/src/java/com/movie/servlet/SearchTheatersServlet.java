package com.movie.servlet;

import com.movie.dao.MovieDAO;
import com.movie.model.Movie;
import com.movie.model.Theater;
import com.movie.model.ShowTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

@WebServlet("/SearchTheatersServlet")
public class SearchTheatersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String location = request.getParameter("location");
            if (location == null || location.trim().isEmpty()) {
                out.println("<p>Please enter a location!</p>");
                return;
            }

            // Get DB connection from servlet context
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            MovieDAO movieDAO = new MovieDAO(conn);

            // Fetch movies that are playing in theaters in the given location
            List<Movie> movies = movieDAO.getMoviesWithTheatersAndShowTimes();

            boolean hasResults = false;

            out.println("<div class='movie-container'>");

            for (Movie movie : movies) {
                for (Theater theater : movie.getTheaters()) {
                    if (theater.getLocation().equalsIgnoreCase(location)) {
                        hasResults = true;
                        out.println("<div class='movie-card'>");
                        out.println("<h3>" + movie.getTitle() + "</h3>");
                        out.println("<p>Genre: " + movie.getGenre() + "</p>");
                        out.println("<p>Rating: " + movie.getRating() + "</p>");
                        out.println("<p>Theater: " + theater.getName() + "</p>");
                        out.println("<p>Location: " + theater.getLocation() + "</p>");
                        out.println("<p>Showtimes:</p>");
                        out.println("<ul>");

                        for (ShowTime showTime : theater.getShowTimes()) {
                            out.println("<li>" + showTime.getFormattedShowTime() + "</li>");
                        }

                        out.println("</ul>");
                        // Generate the "Book Now" button with the correct link
                        out.println("<button class='book-btn' onclick=\"window.location.href='book.jsp?movie_id=" + movie.getId() + "&theater_id=" + theater.getId() + "'\">Book Now</button>");
                        out.println("</div>");
                    }
                }
            }

            out.println("</div>");

            if (!hasResults) {
                out.println("<p>No theaters found in this location.</p>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching theaters and movies.</p>");
        }
    }
}
