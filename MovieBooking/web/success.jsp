<%@ page import="java.sql.*" %>
<%@ page import="com.movie.utils.DBConnection" %>
<%@ page import="com.movie.model.User" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page language="java" %>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        @media print {
    .no-print {
        display: none !important;
    }
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-image: url('images/ticket_bg.png'); /* Replace with your actual image path */
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
    background-attachment: fixed;
    height: 100vh;
    margin: 0;
}
.center-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    position: relative;
}

.ticket-wrapper {
    position: relative;
    width: fit-content;
}

.ticket {
    width: 450px;
    display: block;
    border-radius: 12px;
}

.ticket-text {
    position: absolute;
    top: 57%;
    left: 50%;
    color: black;
    font-size: 12px;
}

        .button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    // Retrieving session and user details from the session implicitly
    User loggedInUser = (User) session.getAttribute("user");
    String userName = (loggedInUser != null) ? loggedInUser.getName() : "Guest";
    
    // Retrieving booking details from session
    String movieTitle = (String) session.getAttribute("movieTitle");
    movieTitle = (movieTitle != null) ? movieTitle : "Unknown Movie";
    
    String theaterName = (String) session.getAttribute("theaterName");
    theaterName = (theaterName != null) ? theaterName : "Unknown Theater";
    
    String showTime = (String) session.getAttribute("selectedShowtime");
    showTime = (showTime != null) ? showTime : "Unknown Time";
    
    String seatNo = (String) session.getAttribute("seatNo");
    seatNo = (seatNo != null) ? seatNo : "N/A";
%>

<div class="center-container">
    <div class="ticket-wrapper">
        <img src="images/Ticket.png" alt="Movie Ticket" class="ticket">
        <div class="ticket-text">
            <h3 style="color: #4CAF50;">Booking Confirmed!</h3>
            <p><strong>Name:</strong> <%= userName %></p>
            <p><strong>Movie:</strong> <%= movieTitle %></p>
            <p><strong>Theater:</strong> <%= theaterName %></p>
            <p><strong>Showtime:</strong> <%= showTime %></p>
            <p><strong>Seats:</strong> <%= seatNo %></p>
        </div>
    </div>
   <div class="no-print">
    <a href="book.jsp" class="button">Book Another</a>
    <a href="#" onclick="window.print();" class="button">Download</a>
</div>

</div>


</body>

</html>
