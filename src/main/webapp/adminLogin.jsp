<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #121212;
            color: #ffffff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .card {
            background-color: #1e1e1e;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            overflow: hidden;
        }

        .card-header {
            padding: 24px;
            border-bottom: 1px solid #333;
            text-align: center;
        }

        .card-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .card-description {
            color: #aaa;
            font-size: 14px;
        }

        .card-content {
            padding: 24px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #ccc;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            background-color: #333;
            border: 1px solid #444;
            border-radius: 4px;
            color: white;
            font-size: 16px;
        }

        input:focus {
            outline: none;
            border-color: #555;
        }

        input::placeholder {
            color: #777;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        button:hover {
            background-color: #555;
        }

        .error-message {
            background-color: rgba(192, 57, 43, 0.2);
            border: 1px solid #e74c3c;
            color: #e74c3c;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 16px;
        }

        .card-footer {
            padding: 16px 24px;
            border-top: 1px solid #333;
            text-align: center;
        }

        .card-footer a {
            color: #ccc;
            text-decoration: underline;
        }

        .card-footer a:hover {
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">Login to your account</h1>
            <p class="card-description">Please enter your credentials</p>
        </div>

        <div class="card-content">
            <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <form action="AdminController" method="post">
                <input type="hidden" name="action" value="login">

                <div class="form-group">
                    <label for="username">ID</label>
                    <input type="text" id="username" name="username" placeholder="S001" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="•••••••••••••" required>
                </div>

                <button type="submit">Login</button>
            </form>
        </div>

        <div class="card-footer">
            <p>Not registered? <a href="signup.jsp">Sign up here</a></p>
        </div>
    </div>
</div>

</body>
</html>
