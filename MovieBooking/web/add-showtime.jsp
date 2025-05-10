<%@ page import="java.util.List, com.movie.dao.MovieDAO, com.movie.model.Movie" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    int theaterId = Integer.parseInt(request.getParameter("theater_id"));
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> movies = movieDAO.getAllMovies();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Show Time</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .btn-custom {
            background-color: #007bff;
            color: #fff;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        h2 {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Add Show Time</h2>

    <form action="AddShowtimeServlet" method="post">
        <input type="hidden" name="theaterId" value="<%= theaterId %>">

        <!-- Movie Selection -->
        <div class="mb-3">
            <label for="movieSelect" class="form-label">Select Movie:</label>
            <select name="movieId" id="movieSelect" class="form-select" required>
                <% for (Movie m : movies) { %>
                    <option value="<%= m.getId() %>"><%= m.getTitle() %></option>
                <% } %>
            </select>
        </div>

        <!-- Show Time Input -->
        <div class="mb-3">
            <label for="showTime" class="form-label">Show Time:</label>
            <input type="datetime-local" name="showTime" id="showTime" class="form-control" required>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-custom w-100">Add Show Time</button>
    </form>

    <!-- Back Link -->
    <div class="text-center mt-3">
        <a href="admin-dashboard.jsp" class="btn btn-link">Back to Dashboard</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
