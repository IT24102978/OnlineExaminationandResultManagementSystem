<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Online Examination System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: url('images/l.jpg') no-repeat center center fixed;
            background-size: 100% 100%;
            backdrop-filter: blur(3px);
        }
        .signup-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .signup-box {
            background: lightsteelblue;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            width: 100%;
        }
        .signup-box h4 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 600;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container signup-container">
    <div class="signup-box">
        <h4>Sign Up</h4>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger"><%= request.getParameter("error") %></div>
        <% } %>
        <form action="StudentController" method="post">
            <input type="hidden" name="action" value="signup">
            <div class="mb-3">
                <label for="id" class="form-label">Student ID</label>
                <input type="text" class="form-control" id="id" name="id" placeholder="Enter your Student ID" required>
            </div>
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter your first name" required>
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter your last name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <label for="course" class="form-label">Course</label>
                <input type="text" class="form-control" id="course" name="course" placeholder="Enter your course" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Sign Up</button>
            <div class="text-center mt-3">
                <p>Already have an account? <a href="studentLogin.jsp">Sign In</a></p>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>