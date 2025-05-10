package com.movie.servlet;

import com.movie.dao.MovieDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RemoveMovieServlet")
public class RemoveMovieServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get movie ID from request
            String movieIdStr = request.getParameter("id");

            // Validate ID
            if (movieIdStr == null || movieIdStr.isEmpty()) {
                response.sendRedirect("error.jsp?msg=Invalid movie ID");
                return;
            }

            int movieId = Integer.parseInt(movieIdStr);
            MovieDAO movieDAO = new MovieDAO();

            // Remove movie and redirect accordingly
            if (movieDAO.deleteMovie(movieId)) {
                response.sendRedirect("remove.jsp?msg=Movie removed successfully");
            } else {
                response.sendRedirect("error.jsp?msg=Failed to remove movie");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?msg=Invalid movie ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Internal server error");
        }
    }
}
