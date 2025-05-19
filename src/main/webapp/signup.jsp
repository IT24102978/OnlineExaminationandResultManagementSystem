<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Registration</title>
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
      max-width: 500px;
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

    .form-row {
      display: flex;
      gap: 16px;
    }

    .form-row .form-group {
      flex: 1;
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #ccc;
      font-size: 14px;
    }

    input, select {
      width: 100%;
      padding: 10px 12px;
      background-color: #333;
      border: 1px solid #444;
      border-radius: 4px;
      color: white;
      font-size: 16px;
    }

    input:focus, select:focus {
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

    .card-footer {
      padding: 16px 24px;
      border-top: 1px solid #333;
      text-align: center;
    }

    .card-footer p {
      font-size: 14px;
      color: #aaa;
    }

    .card-footer a {
      color: #ccc;
      text-decoration: underline;
    }

    .card-footer a:hover {
      color: white;
    }

    footer {
      background-color: #1a1a1a;
      padding: 24px;
      text-align: center;
    }

    footer p {
      color: #aaa;
      font-size: 14px;
      margin-bottom: 8px;
    }

    .footer-links {
      display: flex;
      justify-content: center;
      gap: 24px;
      margin-top: 8px;
    }

    .footer-links a {
      color: #aaa;
      text-decoration: none;
      transition: color 0.2s;
    }

    .footer-links a:hover {
      color: white;
    }

    .success-message {
      background-color: rgba(39, 174, 96, 0.2);
      border: 1px solid #27ae60;
      color: #2ecc71;
      padding: 12px;
      border-radius: 4px;
      margin-bottom: 16px;
      display: none;
    }
  </style>
</head>
<body>
<%
  // Process form submission
  String successMessage = "";
  if (request.getMethod().equalsIgnoreCase("post")) {
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String school = request.getParameter("school");
    String age = request.getParameter("age");
    String email = request.getParameter("email");
    String classChoice = request.getParameter("class");

    // Here you would typically save the data to a database
    // For this example, we'll just set a success message
    successMessage = "Registration successful! Thank you for signing up.";
  }
%>

<div class="container">
  <div class="card">
    <div class="card-header">
      <h1 class="card-title">Student Registration</h1>
      <p class="card-description">Enter your information to create an account</p>
    </div>

    <div class="card-content">
      <% if (!successMessage.isEmpty()) { %>
      <div class="success-message" style="display: block;">
        <%= successMessage %>
      </div>
      <% } %>

      <form method="post" action="signup.jsp">
        <div class="form-row">
          <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" placeholder="John" required>
          </div>

          <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
          </div>
        </div>

        <div class="form-group">
          <label for="school">School</label>
          <input type="text" id="school" name="school" placeholder="City High School" required>
        </div>

        <div class="form-group">
          <label for="age">Age</label>
          <input type="number" id="age" name="age" placeholder="16" required>
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" placeholder="john.doe@example.com" required>
        </div>

        <div class="form-group">
          <label for="class">Class</label>
          <select id="class" name="class" required>
            <option value="" disabled selected>Select a class</option>
            <option value="maths">Maths</option>
            <option value="science">Science</option>
            <option value="it">IT</option>
          </select>
        </div>

        <button type="submit">Register</button>
      </form>
    </div>

    <div class="card-footer">
      <p>
        Already have an account?
        <a href="adminLogin.jsp">Sign in</a>
      </p>
    </div>
  </div>
</div>

<footer>
  <p>&copy; <%= new java.util.Date().getYear() + 1900 %> PGNO 198. All rights reserved.</p>
  <div class="footer-links">
    <a href="#">Terms</a>
    <a href="#">Privacy</a>
    <a href="#">Contact</a>
  </div>
</footer>
</body>
</html>