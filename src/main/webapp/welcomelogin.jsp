<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome - Online Examination System</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background: url('images/wallpaper.jpg') no-repeat center center fixed;
      background-size: cover;
      backdrop-filter: blur(2px);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
      color: #333;
    }
    .content {
      background: rgba(192, 192, 192, 0.7);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      text-align: center;
      max-width: 500px;
      width: 100%;
    }
    .content h1 {
      margin-bottom: 20px;
      font-weight: bold;
    }
    .btn {
      margin: 8px;
      width: 200px;
    }
  </style>
</head>
<body>
<div class="content">
  <h1>Welcome to the Online Examination System</h1>
  <p>Select your role to continue:</p>
  <a href="index.jsp" class="btn btn-danger">Admin Login</a>
  <a href="studentLogin.jsp" class="btn btn-primary">Student Login</a>
  <hr>
  <p>New student?</p>
  <a href="signup2.jsp" class="btn btn-secondary">Sign Up</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
