package com.movie.servlet;

import com.movie.dao.AdminDAO;
import com.movie.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.validateAdmin(email, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminEmail", admin.getEmail()); // Store admin email in session
            response.sendRedirect("admin-dashboard.jsp"); // Redirect to admin dashboard
        } else {
            response.sendRedirect("admin-login.jsp?error=Invalid credentials");
        }
    }
}

