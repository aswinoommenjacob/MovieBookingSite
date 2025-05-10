<%@page import="com.movie.dao.BookingDAO"%>
<%@page import="com.movie.model.Booking"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.movie.utils.DBConnection"%>
<%@page import="java.util.List"%>
<%@page import="com.movie.dao.MovieDAO, com.movie.model.Movie"%>
<%@page import="com.movie.dao.ShowTimeDAO"%>
<%@page import="com.movie.dao.TheaterDAO, com.movie.model.Theater"%>

<%
    HttpSession adminSession = request.getSession(false);
    String adminEmail = (adminSession != null) ? (String) adminSession.getAttribute("adminEmail") : null;
    if (adminEmail == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection(); 

    MovieDAO movieDAO = new MovieDAO(conn);
    List<Movie> movies = movieDAO.getAllMovies();

    TheaterDAO theaterDAO = new TheaterDAO(conn);
    List<Theater> theaters = theaterDAO.getAllTheaters();

    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getAllBookings();

    ShowTimeDAO showTimeDAO = new ShowTimeDAO(conn);
    List<Object[]> showtimes = showTimeDAO.getAllShowtimesWithDetails();

    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Netflix Style</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            background: #141414;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
            background: #E50914;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .logout-btn:hover {
            background: #b20710;
        }
        .container {
            max-width: 1200px;
            margin: 80px auto 40px;
            padding: 0 20px;
        }
        h2, h3 {
            color: #E50914;
            text-align: center;
            margin-bottom: 20px;
        }
        .section {
            margin-bottom: 50px;
        }
        .card-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .movie-card, .theater-card {
            background: #222;
            border-radius: 10px;
            padding: 15px;
            width: 260px;
            box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .movie-card img {
            width: 100%;
            height: 300px;
            border-radius: 5px;
            object-fit: cover;
        }
        .movie-card h4, .theater-card h4 {
            margin: 10px 0 5px;
            text-align: center;
        }
        .movie-card p, .theater-card p {
            text-align: center;
            margin: 0 0 10px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            width: 100%;
        }
        .remove-btn, .add-btn {
            background: #E50914;
            border: none;
            color: white;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            flex: 1;
            text-align: center;
            text-decoration: none;
        }
        .remove-btn:hover, .add-btn:hover {
            background: #b20710;
        }
        .add-section-btn {
            margin-top: 20px;
            display: block;
            background: #E50914;
            padding: 12px 25px;
            margin-left: auto;
            margin-right: auto;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
        }
        .modal-content {
            background: #222;
            padding: 20px;
            width: 50%;
            margin: 5% auto;
            border-radius: 10px;
        }
        .close {
            float: right;
            color: red;
            cursor: pointer;
            font-size: 24px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            color: white;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #333;
        }
        th {
            background-color: #333;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border-radius: 5px;
            border: none;
            background: #333;
            color: white;
        }
    </style>
</head>
<body>

<a href="admin-logout.jsp" class="logout-btn">Logout</a>

<div class="container">
    <h2>Welcome, Admin</h2>
    <% if (msg != null) { %>
        <p style="color: green; text-align:center;"><%= msg %></p>
    <% } %>

    <!-- Movies Section -->
    <div class="section">
        <h3>Movies List</h3>
        <div class="card-wrapper">
            <% for (Movie m : movies) { %>
                <div class="movie-card">
                    <img src="<%= (m.getImageUrl() != null && !m.getImageUrl().isEmpty()) ? m.getImageUrl() : "images/default.jpg" %>" alt="Movie">
                    <h4><%= m.getTitle() %></h4>
                    <p><%= m.getGenre() %> | <%= m.getDuration() %> min</p>
                    <button class="remove-btn" onclick="confirmDelete('RemoveMovieServlet?id=<%= m.getId() %>')">Remove</button>
                </div>
            <% } %>
        </div>
        <button class="add-section-btn" onclick="showModal('movieModal')">+ Add Movie</button>
    </div>

    <!-- Theaters Section -->
    <div class="section">
        <h3>Theaters List</h3>
        <div class="card-wrapper">
            <% for (Theater t : theaters) { %>
                <div class="theater-card">
                    <h4><%= t.getName() %></h4>
                    <p><%= t.getLocation() %></p>
                    <div class="btn-group">
                        <button class="remove-btn" onclick="confirmDelete('RemoveTheaterServlet?id=<%= t.getId() %>')">Remove</button>
                        <a href="add-show-time.jsp?theater_id=<%= t.getId() %>" class="add-btn">Showtimes</a>
                    </div>
                </div>
            <% } %>
        </div>
        <button class="add-section-btn" onclick="showModal('theaterModal')">+ Add Theater</button>
    </div>

    <!-- Showtimes Section -->
    <div class="section">
        <h3>Showtimes List</h3>
        <table>
            <tr>
                <th>Movie</th>
                <th>Theater</th>
                <th>Show Time</th>
                <th>Action</th>
            </tr>
            <% for (Object[] row : showtimes) {
                String movieTitle = (String) row[0];
                String theaterName = (String) row[1];
                java.sql.Timestamp showTime = (java.sql.Timestamp) row[2];
                int showtimeId = (Integer) row[3];
            %>
            <tr>
                <td><%= movieTitle %></td>
                <td><%= theaterName %></td>
                <td><%= showTime.toString() %></td>
                <td>
                    <button class="remove-btn" onclick="confirmDelete('RemoveShowtimeServlet?id=<%= showtimeId %>')">Remove</button>
                </td>
            </tr>
            <% } %>
        </table>
        <button class="add-section-btn" onclick="showModal('showtimeModal')">+ Add Showtime</button>
    </div>
</div>

<!-- Modals -->
<!-- Movie Modal -->
<div class="modal" id="movieModal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('movieModal')">&times;</span>
        <h3>Add New Movie</h3>
        <form action="AddMovieServlet" method="post">
            <input type="text" name="title" placeholder="Title" required>
            <input type="text" name="genre" placeholder="Genre" required>
            <input type="number" name="duration" placeholder="Duration (minutes)" required>
            <input type="text" name="image_url" placeholder="Image URL">
            <button type="submit" class="add-btn">Add Movie</button>
        </form>
    </div>
</div>

<!-- Theater Modal -->
<div class="modal" id="theaterModal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('theaterModal')">&times;</span>
        <h3>Add New Theater</h3>
        <form action="AddTheaterServlet" method="post">
    <input type="text" name="name" placeholder="Theater Name" required>
    <input type="text" name="location" placeholder="Location" required>
    <input type="url" name="locationUrl" placeholder="Google Maps URL (Location URL)" required>

    <button type="submit" class="add-btn">Add Theater</button>
</form>

    </div>
</div>

<!-- Showtime Modal -->
<div class="modal" id="showtimeModal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('showtimeModal')">&times;</span>
        <h3>Add New Showtime</h3>
        <form action="AddShowTimeServlet" method="post">
            <label for="movieId">Movie:</label>
            <select name="movieId" required>
                <% for (Movie m : movies) { %>
                    <option value="<%= m.getId() %>"><%= m.getTitle() %></option>
                <% } %>
            </select>
            <label for="theaterId">Theater:</label>
            <select name="theaterId" required>
                <% for (Theater t : theaters) { %>
                    <option value="<%= t.getId() %>"><%= t.getName() %></option>
                <% } %>
            </select>
            <label for="showTime">Show Time:</label>
            <input type="datetime-local" name="showTime" required>
            <button type="submit" class="add-btn">Add Showtime</button>
        </form>
    </div>
</div>

<script>
    function showModal(id) {
        document.getElementById(id).style.display = 'block';
    }
    function closeModal(id) {
        document.getElementById(id).style.display = 'none';
    }
    function confirmDelete(url) {
        if (confirm("Are you sure you want to remove this?")) {
            window.location.href = url;
        }
        
    }
</script>

</body>
</html>
