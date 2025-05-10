package com.movie.servlet;

import com.movie.dao.MovieDAO;
import com.movie.model.Movie;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> movies = movieDAO.getMoviesWithTheatersAndShowTimes();  // ✅ FIXED: Fetch theaters and showtimes

        request.setAttribute("movies", movies);
        request.getRequestDispatcher("movies.jsp").forward(request, response);
    }
}

