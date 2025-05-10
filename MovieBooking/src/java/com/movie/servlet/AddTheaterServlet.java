package com.movie.servlet;

import com.movie.dao.TheaterDAO;
import com.movie.model.Theater;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddTheaterServlet")
public class AddTheaterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String locationUrl = request.getParameter("locationUrl"); // ✅ New field

            // Get DB connection from servlet context
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            TheaterDAO theaterDAO = new TheaterDAO(conn);

            // ✅ Use new constructor with locationUrl
            boolean added = theaterDAO.addTheater(new Theater(name, location, locationUrl));

            if (added) {
                response.sendRedirect("admin-dashboard.jsp?msg=Theater added successfully");
            } else {
                response.sendRedirect("admin-dashboard.jsp?msg=Error adding theater");
            }
        } catch (Exception e) {
            e.printStackTrace();
            
            response.sendRedirect("admin-dashboard.jsp?msg=Invalid input");
        }
    }
}
