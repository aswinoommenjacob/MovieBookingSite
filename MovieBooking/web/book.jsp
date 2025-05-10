<%@ page import="java.sql.*" %>
<%@ page import="com.movie.utils.DBConnection" %>
<%@ page import="com.movie.model.User" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
    HttpSession userSession = request.getSession(false);
    User loggedInUser = (userSession != null && userSession.getAttribute("user") instanceof User) ? 
                        (User) userSession.getAttribute("user") : null;

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String movieIdParam = request.getParameter("movie_id");
    String theaterIdParam = request.getParameter("theater_id");
    String selectedShowtimeId = request.getParameter("showtime_id");

    int movieId = 0, theaterId = 0;
    String movieTitle = "", theaterName = "", locationUrl = "#";

    // Validate and parse parameters
    if (movieIdParam != null && theaterIdParam != null) {
        try {
            movieId = Integer.parseInt(movieIdParam);
            theaterId = Integer.parseInt(theaterIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp?error=Invalid movie or theater ID.");
            return;
        }
    } else {
        response.sendRedirect("index.jsp?error=Missing movie or theater.");
        return;
    }

    try (Connection con = DBConnection.getConnection()) {
        // Fetch movie details
        PreparedStatement psMovie = con.prepareStatement("SELECT title FROM movies WHERE id = ?");
        psMovie.setInt(1, movieId);
        ResultSet rsMovie = psMovie.executeQuery();
        if (rsMovie.next()) movieTitle = rsMovie.getString("title");

        // Fetch theater details
        PreparedStatement psTheater = con.prepareStatement("SELECT name, location_url FROM theaters WHERE id = ?");
        psTheater.setInt(1, theaterId);
        ResultSet rsTheater = psTheater.executeQuery();
        if (rsTheater.next()) {
            theaterName = rsTheater.getString("name");
            locationUrl = rsTheater.getString("location_url");
        }

        // Set movie and theater information in session
        session.setAttribute("movieTitle", movieTitle);
        session.setAttribute("theaterName", theaterName);
        session.setAttribute("locationUrl", locationUrl);
    } catch (Exception e) {
        response.sendRedirect("index.jsp?error=Error fetching data.");
        return;
    }

    // Determine default showtime if not selected
    if (selectedShowtimeId == null) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id FROM movie_theater WHERE movie_id = ? AND theater_id = ? LIMIT 1");
            ps.setInt(1, movieId);
            ps.setInt(2, theaterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                selectedShowtimeId = String.valueOf(rs.getInt("id"));
            }
        }
    }
    if (selectedShowtimeId != null) {
    try (Connection con = DBConnection.getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT show_time FROM movie_theater WHERE id = ?");
        ps.setInt(1, Integer.parseInt(selectedShowtimeId));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String showTime = rs.getString("show_time");
            session.setAttribute("selectedShowtime", showTime);
        }
    } catch (Exception e) {
        e.printStackTrace(); // Optional: for debugging
    }
}


    // Load booked seats
    List<String> bookedSeats = new ArrayList<>();
    if (selectedShowtimeId != null) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement psBooked = con.prepareStatement(
                "SELECT seat_no FROM bookings WHERE movie_id = ? AND theater_id = ? AND showtime_id = ?");
            psBooked.setInt(1, movieId);
            psBooked.setInt(2, theaterId);
            psBooked.setInt(3, Integer.parseInt(selectedShowtimeId));
            ResultSet rsBooked = psBooked.executeQuery();
            while (rsBooked.next()) {
                String seatString = rsBooked.getString("seat_no");
                if (seatString != null) {
                    String[] parts = seatString.split(",");
                    for (String seat : parts) {
                        bookedSeats.add(seat.trim());
                    }
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Movie Ticket</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0f0f0f;
            color: white;
            text-align: center;
            padding: 30px;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #1c1c1c;
            padding: 15px 30px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .topbar h2 {
            margin: 0;
            font-size: 24px;
            color: #e50914;
        }
        .topbar .map-button img {
            width: 26px;
            height: 26px;
        }
        .showtime-select label {
            font-weight: bold;
        }
        .container {
            max-width: 860px;
            margin: auto;
            padding: 20px;
            background: rgba(255,255,255,0.05);
            border-radius: 10px;
        }
        .screen {
            background: #e50914;
            padding: 15px;
            margin: 30px auto 15px;
            font-weight: bold;
            width: 90%;
            border-radius: 5px;
            letter-spacing: 2px;
        }
        .seats {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 10px;
        }
        .row {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 6px 0;
        }
        .row-label {
            width: 25px;
            margin-right: 10px;
            font-weight: bold;
            color: #bbb;
        }
        .seat {
            width: 32px;
            height: 32px;
            margin: 2px;
            font-size: 12px;
            background: #444;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.2s;
        }
        .seat:hover {
            transform: scale(1.1);
        }
        .seat.selected {
            background: #1de9b6;
        }
        .seat.occupied {
            background: red;
            cursor: not-allowed;
        }
        .aisle {
            width: 30px;
        }
        .btn {
            margin: 30px 10px 10px;
            padding: 12px 30px;
            font-size: 16px;
            color: white;
            background: #e50914;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background: #b20710;
            transform: scale(1.05);
        }
        .legend {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .legend span {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .legend-box {
            width: 20px;
            height: 20px;
            border-radius: 3px;
        }
    </style>
</head>
<body>

<div class="topbar">
    <h2>Book a Ticket for: <%= movieTitle %> at <%= theaterName %></h2>
    <a href="<%= locationUrl %>" target="_blank" title="View on Google Maps" class="map-button">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/marker.png" alt="Map">
    </a>
</div>

<div class="showtime-select">
    <form method="get" action="book.jsp" id="showtimeForm">
        <input type="hidden" name="movie_id" value="<%= movieId %>">
        <input type="hidden" name="theater_id" value="<%= theaterId %>">
        <input type="hidden" name="showtime_id" id="showtimeInput" value="<%= selectedShowtimeId %>">
        <label>Select Showtime:</label>
        <div style="display: flex; gap: 10px; flex-wrap: wrap; justify-content: center; margin-top: 10px;">
            <%
                try (Connection con = DBConnection.getConnection()) {
                    PreparedStatement ps = con.prepareStatement("SELECT id, show_time FROM movie_theater WHERE movie_id = ? AND theater_id = ?");
                    ps.setInt(1, movieId);
                    ps.setInt(2, theaterId);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int sid = rs.getInt("id");
                        String time = rs.getString("show_time");
                        boolean isSelected = selectedShowtimeId != null && selectedShowtimeId.equals(String.valueOf(sid));
            %>
                <button type="button" onclick="selectShowtime('<%= sid %>')" 
                        style="padding: 10px 20px; border-radius: 5px; background: <%= isSelected ? "#1de9b6" : "#444" %>; color: white; border: none; cursor: pointer;">
                    <%= time %>
                </button>
            <%
                    }
                }
            %>
        </div>
    </form>
</div>

<div class="container">
    <div class="screen">SCREEN</div>
    <div class="seats" id="seatsContainer">
        <% 
            int totalRows = 12;
            for (int i = 0; i < totalRows; i++) {
                char rowLetter = (char)('A' + i);
                int seatsPerRow = (rowLetter >= 'J') ? 10 : 14;
        %>
            <div class="row">
                <span class="row-label"><%= rowLetter %></span>
                <% for (int j = 1; j <= seatsPerRow; j++) { 
                       String seatNo = "" + rowLetter + j;
                       boolean occupied = bookedSeats.contains(seatNo);
                %>
                    <% if (j == (seatsPerRow / 2 + 1)) { %>
                        <div class="aisle"></div>
                    <% } %>
                    <div class="seat <%= occupied ? "occupied" : "" %>" data-seat="<%= seatNo %>">
                        <%= j %>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <form action="BookingServlet" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="user_id" value="<%= loggedInUser.getId() %>">
        <input type="hidden" name="movie_id" value="<%= movieId %>">
        <input type="hidden" name="theater_id" value="<%= theaterId %>">
        <input type="hidden" name="showtime_id" value="<%= selectedShowtimeId %>">
        <input type="hidden" name="seat_no" id="selectedSeats">
        <button type="submit" class="btn">Confirm Booking</button>
    </form>

    <div class="legend">
        <span><div class="legend-box" style="background:#444;"></div> Available</span>
        <span><div class="legend-box" style="background:red;"></div> Booked</span>
        <span><div class="legend-box" style="background:#1de9b6;"></div> Selected</span>
    </div>
</div>

<script>
    function selectShowtime(showtimeId) {
        document.getElementById('showtimeInput').value = showtimeId;
        document.getElementById('showtimeForm').submit();
    }

    const seats = document.querySelectorAll('.seat:not(.occupied)');
    const selectedSeatsInput = document.getElementById('selectedSeats');
    let selectedSeats = [];

    seats.forEach(seat => {
        seat.addEventListener('click', () => {
            const seatVal = seat.dataset.seat;

            if (seat.classList.contains('selected')) {
                seat.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s !== seatVal);
            } else {
                seat.classList.add('selected');
                selectedSeats.push(seatVal);
            }

            selectedSeatsInput.value = selectedSeats.join(',');
        });
    });
</script>

</body>
</html>