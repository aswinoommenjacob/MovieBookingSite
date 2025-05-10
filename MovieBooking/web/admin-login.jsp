<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        /* ? Netflix Dark Theme */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #141414;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 360px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(255, 0, 0, 0.4);
            text-align: center;
        }

        h2 {
            color: #e50914;
            margin-bottom: 20px;
            font-size: 24px;
        }

        label {
            display: block;
            text-align: left;
            font-size: 14px;
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        input:focus {
            outline: 2px solid #e50914;
            background: rgba(255, 255, 255, 0.3);
        }

        button {
            width: 100%;
            padding: 12px;
            background: #e50914;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
            transition: background 0.3s, transform 0.2s;
        }

        button:hover {
            background: #b20710;
            transform: scale(1.05);
        }

        .error {
            color: #ff3d3d;
            margin-top: 10px;
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 400px) {
            .container {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <%-- Display error message if login fails --%>
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error"><%= error %></p>
        <%
            }
        %>
    </div>

</body>
</html>
