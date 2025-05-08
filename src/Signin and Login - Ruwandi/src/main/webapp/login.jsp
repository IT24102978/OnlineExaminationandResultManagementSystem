<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Online Examination System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: url('images/lo.jpg') no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(4px);
        }
        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-box {
            background: silver;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
        }
        .login-box h5 {
            margin-bottom: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container login-container">
    <div class="login-box">
        <h5>Login to start your session</h5>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger"><%= request.getParameter("error") %></div>
        <% } %>
        <form action="StudentController" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <label for="id" class="form-label">Student ID</label>
                <input type="text" class="form-control" id="id" name="id" placeholder="Enter your Student ID" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember Me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <div class="text-center mt-3">
                <p>Don't have an account? <a href="signup.jsp">Sign up</a></p>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>