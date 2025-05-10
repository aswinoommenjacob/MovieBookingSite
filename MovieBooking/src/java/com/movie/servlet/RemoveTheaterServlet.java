package com.movie.servlet;

import com.movie.dao.TheaterDAO;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RemoveTheaterServlet")
public class RemoveTheaterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int theaterId = Integer.parseInt(request.getParameter("id"));

            // Get DB connection from servlet context
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            TheaterDAO theaterDAO = new TheaterDAO(conn);

            boolean removed = theaterDAO.removeTheater(theaterId);

            if (removed) {
                response.sendRedirect("admin-dashboard.jsp?msg=Theater removed successfully");
            } else {
                response.sendRedirect("admin-dashboard.jsp?msg=Error removing theater");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?msg=Invalid ID");
        }
    }
}
