<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.oop_project.Student" %>
<%
  Student student = (Student) session.getAttribute("student");
  String userFirstName = student != null ? student.getFirstName() : "User";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Exam Score</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
  <style>
    html, body {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', sans-serif;
      height: 100%;
    }

    body {
      padding-top: 50px;
      overflow-x: hidden;
      background: url("images/wallpaper.jpg") no-repeat center center fixed;
      background-size: cover;
      backdrop-filter: blur(5px);
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .top-bar {
      width: 100%;
      height: 70px;
      background: black;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      position: fixed;
      top: 0;
      left: 0;
      z-index: 1000;
      color: white;
      font-weight: 600;
      user-select: none;
    }

    .menu-btn {
      font-size: 24px;
      background: transparent;
      border: none;
      color: white;
      padding: 10px;
      cursor: pointer;
    }

    .welcome-msg {
      font-size: 1.2rem;
      margin-top: 10px;
      padding-left: 10px;
    }

    .sidebar {
      width: 250px;
      height: 100vh;
      background: #333;
      position: fixed;
      top: 70px;
      left: -250px;
      transition: left 0.3s ease-in-out;
      padding-top: 20px;
      color: white;
      z-index: 999;
    }

    .sidebar.active {
      left: 0;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .sidebar ul li {
      padding: 15px;
      cursor: pointer;
      border-bottom: 1px solid #444;
    }

    .sidebar ul li:hover {
      background: #555;
    }

    .sidebar ul li a {
      text-decoration: none;
      font-weight: bold;
      color: white;
      font-family: "Poppins", sans-serif;
    }

    .sidebar ul li a:hover {
      color: #3498db;
    }

    .footer {
      background-color: #3b4a68;
      color: white;
      text-align: center;
      padding: 12px;
      font-size: 14px;
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
    }

    .score-container {
      background-color: #ffffff;
      padding: 40px 60px;
      border-radius: 16px;
      box-shadow: 0 10px 20px rgba(100, 0, 200, 0.1);
      text-align: center;
      max-width: 600px;
      margin: 100px auto 80px;
      color: #333;
    }

    h2 {
      color: #3b4a68;
      margin-bottom: 20px;
    }

    .score {
      font-size: 24px;
      font-weight: bold;
      color: #4caf50;
      margin-bottom: 30px;
    }

    .footer-note {
      margin-top: 20px;
      color: #777;
    }

    .back-btn {
      background-color: #007bff;
      color: white;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 8px;
      transition: background 0.2s ease-in-out;
      display: inline-block;
      margin-top: 20px;
    }

    .back-btn:hover {
      background-color: #0056b3;
    }

    [data-lucide] {
      width: 16px;
      height: 16px;
      vertical-align: middle;
      margin-right: 6px;
    }
  </style>
</head>
<body>

<!-- ✅ Top Bar -->
<div class="top-bar">
  <button class="menu-btn" id="menuBtn">☰</button>
  <div class="welcome-msg">Welcome, <%= userFirstName %>!</div>
</div>

<!-- ✅ Sidebar -->
<div class="sidebar" id="sidebar">
  <ul>
    <li><a href="dashboard.jsp">Dashboard</a></li>
    <li><a href="StudentController?action=getStudents">Students</a></li>
    <li><a href="<%= request.getContextPath() %>/showExams?studentId=<%= student.getId() %>">Exams</a></li>
    <li><a href="#">Result</a></li>
    <li><a href="#">Feedbacks</a></li>
    <li><a href="showexam.jsp" style="color: red;">Log out</a></li>
  </ul>
</div>

<!-- ✅ Main Content -->
<div class="score-container">
  <h2>Your Exam Score</h2>
  <div class="score">
    <%= session.getAttribute("score") %> / <%= session.getAttribute("total") %>
  </div>
  <div class="footer-note">
    Thank you for completing your exam!
  </div>
  <a href="<%= request.getContextPath() %>/showExams?studentId=<%= student.getId() %>" class="back-btn">
    <i data-lucide="arrow-left-circle"></i> Back to Exam List
  </a>
</div>

<!-- ✅ Footer -->
<div class="footer">
  &copy; project_group_198 &nbsp; All rights reserved
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
  lucide.createIcons();

  document.getElementById("menuBtn").addEventListener("click", function () {
    const sidebar = document.getElementById("sidebar");
    sidebar.classList.toggle("active");
  });
</script>
</body>
</html>
