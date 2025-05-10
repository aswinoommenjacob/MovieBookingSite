<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Theater Removed</title>
</head>
<body>
    <h2>Theater Removed</h2>
    <p><%= request.getParameter("msg") != null ? request.getParameter("msg") : "Operation completed" %></p>
    <a href="admin-dashboard.jsp">Back to Dashboard</a>
</body>
</html>
