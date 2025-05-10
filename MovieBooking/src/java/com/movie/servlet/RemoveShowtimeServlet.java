package com.movie.servlet;

import com.movie.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RemoveShowtimeServlet")
public class RemoveShowtimeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String showtimeIdStr = request.getParameter("id");

        if (showtimeIdStr != null) {
            try {
                int showtimeId = Integer.parseInt(showtimeIdStr);
                Connection conn = DBConnection.getConnection();
                String sql = "DELETE FROM movie_theater WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, showtimeId);
                int rowsAffected = stmt.executeUpdate();
                stmt.close();
                conn.close();

                if (rowsAffected > 0) {
                    response.sendRedirect("admin-dashboard.jsp?msg=Showtime+removed+successfully");
                } else {
                    response.sendRedirect("admin-dashboard.jsp?msg=Showtime+not+found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-dashboard.jsp?msg=Error+removing+showtime");
            }
        } else {
            response.sendRedirect("admin-dashboard.jsp?msg=Invalid+showtime+ID");
        }
    }
}
