<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Movie Booking</title>
    <style>
        /* 🌑 Netflix Dark Theme */
        body {
            font-family: Arial, sans-serif;
            background: #141414;
            color: white;
            text-align: center;
            padding: 50px;
        }

        .container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(255, 0, 0, 0.4);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        h2 {
            color: #e50914; /* Netflix Red */
            font-size: 24px;
            margin-bottom: 15px;
        }

        p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* 🚨 Error Message */
        .error-message {
            color: #ff4c4c;
            font-weight: bold;
        }

        /* 🎬 Button Styling */
        .btn {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background: #e50914; /* Netflix Red */
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s;
        }

        .btn:hover {
            background: #b20710;
            transform: scale(1.05);
            box-shadow: 0px 4px 15px rgba(255, 0, 0, 0.6);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🚨 Booking Failed!</h2>
        <p class="error-message">
            <%= request.getParameter("msg") != null ? request.getParameter("msg") : "Something went wrong!" %>
        </p>
        <a href="home.jsp" class="btn">🔙 Go Back to Home</a>
    </div>
</body>
</html>
