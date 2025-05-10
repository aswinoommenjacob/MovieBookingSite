<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Theater</title>
</head>
<body>
    <h2>Add New Theater</h2>
    <form action="AddTheaterServlet" method="post">
        <label>Theater Name:</label>
        <input type="text" name="name" required>
        <label>Location:</label>
        <input type="text" name="location" required>
        <button type="submit">Add Theater</button>
    </form>
    <a href="admin-dashboard.jsp">Back</a>
</body>
</html>
