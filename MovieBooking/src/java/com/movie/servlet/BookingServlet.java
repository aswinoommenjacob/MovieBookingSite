package com.movie.servlet;

import com.movie.dao.BookingDAO;
import com.movie.dao.MovieDAO;
import com.movie.dao.ShowTimeDAO;
import com.movie.dao.TheaterDAO;
import com.movie.model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                String userIdParam = request.getParameter("user_id");
                String movieIdParam = request.getParameter("movie_id");
                String seatNo = request.getParameter("seat_no");
                String theaterIdParam = request.getParameter("theater_id");
                String showtimeIdParam = request.getParameter("showtime_id");

                // Debugging - Print values
                System.out.println("Received user_id: " + userIdParam);
                System.out.println("Received movie_id: " + movieIdParam);
                System.out.println("Received seat_no: " + seatNo);
                System.out.println("Received theater_id: " + theaterIdParam);
                System.out.println("Received showtime_id: " + showtimeIdParam);

                // Validate inputs
                if (userIdParam == null || userIdParam.isEmpty() ||
                    movieIdParam == null || movieIdParam.isEmpty() ||
                    seatNo == null || seatNo.isEmpty() ||
                    theaterIdParam == null || theaterIdParam.isEmpty() ||
                    showtimeIdParam == null || showtimeIdParam.isEmpty()) {
                    response.sendRedirect("error.jsp");
                    return;
                }

                // Convert string parameters to integers
                int userId = Integer.parseInt(userIdParam);
                int movieId = Integer.parseInt(movieIdParam);
                int theaterId = Integer.parseInt(theaterIdParam);
                int showtimeId = Integer.parseInt(showtimeIdParam);

                // Call the addBooking method of BookingDAO with all parameters
                boolean success = bookingDAO.addBooking(userId, movieId, seatNo, theaterId, showtimeId);

                if (success) {
                    // Set session attributes after successful booking
                    request.getSession().setAttribute("seatNo", seatNo);
                    request.getSession().setAttribute("showtimeId", showtimeId);


                    response.sendRedirect("success.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("book.jsp?error=Invalid input. Please enter correct details.");
            }
        }
    }
}
