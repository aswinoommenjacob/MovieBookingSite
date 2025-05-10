package com.movie.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.movie.utils.DBConnection;

@WebServlet("/register")  // Make sure this matches the form action
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, password) VALUES (?, ?, ?)")) {
            
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            int rowsInserted = ps.executeUpdate();
            
            if (rowsInserted > 0) {
                response.sendRedirect("login.jsp?success=Registration Successful! Please log in.");
            } else {
                response.sendRedirect("register.jsp?error=Registration Failed");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database Error");
        }
    }
}
