<%@ page import="java.util.List" %>
<%@ page import="com.movie.model.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Bookings - Movie Admin</title>
    <style>
        /* 🌑 Netflix Dark Theme */
        body {
            font-family: Arial, sans-serif;
            background: #141414;
            color: white;
            text-align: center;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #e50914; /* Netflix Red */
            margin-bottom: 20px;
        }

        /* 🎟 Booking Table */
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(255, 0, 0, 0.4);
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
        }

        th {
            background: #e50914;
            color: white;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        /* 🚀 Buttons */
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        .remove-btn {
            background: #e50914;
        }

        .remove-btn:hover {
            background: #b20710;
            transform: scale(1.05);
        }

        .back-btn {
            background: #ffffff;
            color: #141414;
        }

        .back-btn:hover {
            background: #cccccc;
            transform: scale(1.05);
        }

        .add-booking {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            margin: 20px auto;
            width: 50%;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(255, 0, 0, 0.4);
        }

        input {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            border: none;
            width: 80%;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .book-btn {
            background: #e50914;
        }

        .book-btn:hover {
            background: #b20710;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <h2>🎟 Movie Bookings</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Movie ID</th>
            <th>Seat No</th>
            <th>Booking Date</th>
            <th>Action</th>
        </tr>
        <%
            List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
            for (Booking booking : bookings) {
        %>
        <tr>
            <td><%= booking.getId() %></td>
            <td><%= booking.getUserId() %></td>
            <td><%= booking.getMovieId() %></td>
            <td><%= booking.getSeatNo() %></td>
            <td><%= booking.getBookingDate() %></td>
            <td>
                <form action="BookingServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                    <button type="submit" class="btn remove-btn">❌ Remove</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <button onclick="window.location.href='admin-dashboard.jsp';" class="btn back-btn">⬅ Back to Admin Panel</button>

    <div class="add-booking">
        <h3>➕ Add Booking</h3>
        <form action="BookingServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="user_id" placeholder="User ID" required><br>
            <input type="text" name="movie_id" placeholder="Movie ID" required><br>
            <input type="text" name="seat_no" placeholder="Seat No" required><br>
            <button type="submit" class="btn book-btn">🎟 Book Now</button>
        </form>
    </div>

</body>
</html>
