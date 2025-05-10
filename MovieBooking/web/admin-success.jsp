<!DOCTYPE html>
<html>
<head>
    <title>Success</title>
    <style>
        /* ? Netflix Dark Theme */
        body {
            font-family: Arial, sans-serif;
            background: #141414;
            color: white;
            text-align: center;
            margin: 0;
            padding: 50px;
        }

        .container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(255, 0, 0, 0.4);
        }

        h2 {
            color: #e50914; /* Netflix Red */
            margin-bottom: 20px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: white;
            background: #e50914;
            padding: 12px 20px;
            font-weight: bold;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
        }

        a:hover {
            background: #b20710;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>? Movie Added Successfully!</h2>
        <a href="admin-dashboard.jsp">? Back to Dashboard</a>
    </div>

</body>
</html>
