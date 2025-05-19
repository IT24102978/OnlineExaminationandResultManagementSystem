<%@ page import="java.util.*, sign_in_and_exam_management.MCQ, sign_in_and_exam_management.Student" %>

<%
    ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
    Student student = (Student) session.getAttribute("student");
    String userFirstName = student != null ? student.getFirstName() : "User";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Exam Submitted</title>
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

        .container {
            max-width: 800px;
            margin: 100px auto 60px;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 20px rgba(100, 0, 200, 0.08);
            color: #333;
        }

        h2 {
            color: #3b4a68;
            margin-bottom: 10px;
        }

        h3 {
            color: #444;
            margin-bottom: 20px;
        }

        .question-block {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .question {
            font-weight: bold;
            color: #3f3f3f;
            margin-bottom: 8px;
        }

        .answer {
            color: #3b4a68;
        }

        .next-btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
            transition: background 0.2s ease-in-out;
            margin-top: 20px;
        }

        .next-btn:hover {
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
    <div class="welcome-msg">Welcome,&nbsp;<%= userFirstName %> !</div>
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
<div class="container">
    <h2><i data-lucide="check-circle"></i> Exam Submitted Successfully!</h2>
    <h3>Your Answers:</h3>

    <% for (int i = 0; i < mcqList.size(); i++) {
        MCQ mcq = mcqList.get(i);
    %>
    <div class="question-block">
        <div class="question">Q<%= i + 1 %>: <%= mcq.getQuestion() %></div>
        <div class="answer">Your Answer: <%= mcq.getUserAnswer() %></div>
    </div>
    <% } %>

    <div style="text-align:center;">
        <a href="score.jsp" class="next-btn">
            <i data-lucide="arrow-right-circle"></i> View Your Marks
        </a>
    </div>
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
