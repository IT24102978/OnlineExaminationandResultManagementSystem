<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Exam Score</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f8f6ff;
      margin: 0;
      padding: 0;
    }

    .header {
      background-color: #5c3d99;
      color: white;
      padding: 15px 40px;
      font-size: 20px;
      font-weight: bold;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .footer {
      background-color: #5c3d99;
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
      margin: 100px auto 80px; /* leave space for footer and header */
    }

    h2 {
      color: #5c3d99;
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
      background-color: #5c3d99;
      color: white;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 8px;
      transition: background 0.2s ease-in-out;
      display: inline-block;
      margin-top: 20px;
    }

    .back-btn:hover {
      background-color: #472f74;
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

<!-- ✅ HEADER -->
<div class="header">
  Online Exam System &nbsp;
</div>

<div class="score-container">
  <h2>Your Exam Score</h2>
  <div class="score">
    <%= session.getAttribute("score") %> / <%= session.getAttribute("total") %>
  </div>
  <div class="footer-note">
    Thank you for completing your exam!
  </div>
  <a href="${pageContext.request.contextPath}/showExams" class="back-btn">
    <i data-lucide="arrow-left-circle"></i> Back to Exam List
  </a>
</div>

<!-- ✅ FOOTER -->
<div class="footer">
  &copy; project_group_198 &nbsp; All rights reserved
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>lucide.createIcons();</script>
</body>
</html>
