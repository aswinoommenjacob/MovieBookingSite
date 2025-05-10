<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Movie Booking</title>
    <style>
        /* 🌑 Netflix Dark Theme */
        body {
            font-family: Arial, sans-serif;
            background: #141414;
            color: white;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            position: relative;
        }

        .container {
            width: 600px; /* Larger login box */
            padding: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0px 6px 15px rgba(255, 0, 0, 0.5);
            text-align: center;
            z-index: 10;
        }

        h2 {
            color: #e50914;
            font-size: 32px;
            margin-bottom: 20px;
        }

        /* 📌 Input Fields */
        input {
            width: 95%;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.3);
        }

        /* 🎬 Button Styling */
        .btn {
            font-size: 20px;
            font-weight: bold;
            color: white;
            background: #e50914;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s;
        }

        .btn:hover {
            background: #b20710;
            transform: scale(1.08);
            box-shadow: 0px 6px 20px rgba(255, 0, 0, 0.7);
        }

        /* 🚨 Error Message */
        .error-message {
            color: #ff4c4c;
            margin-top: 15px;
            font-size: 18px;
        }

        /* 🎥 Fade-in Effect */
        .container {
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 🎭 Movie Icons Styling */
        .movie-icon {
            width: 120px; /* Increased size */
            position: absolute;
            transition: transform 0.5s ease, opacity 0.5s;
        }

        .movie-icon:hover {
            transform: scale(1.1) rotate(10deg);
            opacity: 0.9;
        }

        /* 📌 Adjusted Positions */
        .popcorn1 {
            bottom: 30px;
            height: 600px;
            width:  auto;
            right: 50px;
            transform: rotate(-10deg);
            animation: shake 2s infinite alternate;
        }
        
        .popcorn2 {
            bottom: 20px;
            height: 400px;
            width: auto; 
            right: 50px;
            transform: rotate(10deg);
            animation: shake 3s infinite alternate;
        }

        .movie-reel {
            top: 50px;
            right: 20px;
        }

        .glasses {
            top: 50px;
            left: 20px;
        }

        .clapperboard {
            bottom: 50px;
            left: 10px;
            animation: shake 1s infinite alternate;
        }

        /* 🎭 Shake Animation */
        @keyframes shake {
            0% { transform: translateX(-3px) rotate(-2deg); }
            100% { transform: translateX(3px) rotate(2deg); }
        }

    </style>
</head>
<body>

    <!-- Movie Theme Images -->
    <img src="images/popcorn.png" class="movie-icon popcorn1" alt="Popcorn">
    <img src="images/popcorn.png" class="movie-icon popcorn2" alt="Popcorn">
    <img src="images/movie_icon.png" class="movie-icon movie-reel" alt="Movie Reel">
    <img src="images/3D_glass.png" class="movie-icon glasses" alt="3D Glasses">
    <img src="images/clapperboard.png" class="movie-icon clapperboard" alt="Clapperboard">

    <div class="container">
        <h2>🔓 Login</h2>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email Address" required>
            <br>
            <input type="password" name="password" placeholder="Enter Password" required>
            <br>
            <button type="submit" class="btn">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register Here</a></p>

        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">🚨 Invalid email or password. Please try again.</p>
        <% } %>
    </div>

</body>
</html>
