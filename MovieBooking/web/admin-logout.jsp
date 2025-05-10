<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession != null) {
        adminSession.invalidate(); // Destroy session
    }
    response.sendRedirect("admin-login.jsp"); // Redirect to admin login page
%>
