<%@ page import="com.movie.model.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.movie.utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession userSession = request.getSession(false);
    User loggedInUser = (userSession != null && userSession.getAttribute("user") instanceof User) ? 
                        (User) userSession.getAttribute("user") : null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Movie Booking - Home</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            width: 100%;
            overflow-x: hidden;
            background: black;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header-image {
            width: 100%;
            height: 380px;
            background: url('images/bg.png') no-repeat center center/cover;
            position: relative;
        }

        .header-image::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 200px;
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0), black);
        }

        .nav-links {
            position: absolute;
            top: 20px;
            right: 30px;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin: 0 10px;
            font-weight: bold;
            transition: 0.3s;
        }

        .search-btn {
            background: #e50914;
            color: white;
            border: none;
            padding: 12px 80px;
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            position: absolute;
            bottom: 200px;
            left: 50%;
            transform: translateX(-50%);
        }

        .search-btn:hover {
            background: #b20710;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 10;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #222;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
        }

        .modal-content input {
            width: 80%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background: #333;
            color: white;
            font-size: 16px;
        }

        .close-btn {
            color: white;
            font-size: 20px;
            cursor: pointer;
            float: right;
        }

        .movie-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .movie-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 10px;
            width: 220px;
            text-align: center;
            position: relative;
        }

        .book-btn {
            background: #e50914;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .book-btn:hover {
            background: #b20710;
        }
    </style>
    <script>
        function openModal() {
            console.log("Opening modal...");
            document.getElementById("locationModal").style.display = "flex";
        }

        function closeModal() {
            console.log("Closing modal...");
            document.getElementById("locationModal").style.display = "none";
        }

        function fetchTheaters() {
            let location = document.getElementById("userLocation").value.trim();
            if (!location) {
                alert("Please enter your location!");
                return;
            }

            console.log("Fetching theaters for location:", location);
            
            fetch('SearchTheatersServlet?location=' + encodeURIComponent(location))
                .then(response => response.text())
                .then(data => {
                    console.log("Fetched Data:", data);
                    document.getElementById("movieResults").innerHTML = data;
                    closeModal();
                })
                .catch(error => console.error('Error fetching theaters:', error));
        }
    </script>
</head>
<body>
    <div class="header-image">
        <button class="search-btn" onclick="openModal()">Search Theaters</button>
    </div>
    
    <div class="nav-links">
        <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
    </div>
    
    <div id="locationModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h3>Enter your location</h3>
            <input type="text" id="userLocation" placeholder="Enter city or area">
            <button class="search-btn" onclick="fetchTheaters()">Search</button>
        </div>
    </div>
    
    <div id="movieResults" class="movie-container">
        <!-- Movie cards will be dynamically populated here -->
    </div>
    <div style="height: 400px"></div>
</body>
</html>
