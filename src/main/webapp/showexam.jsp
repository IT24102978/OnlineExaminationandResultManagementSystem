<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, sign_in_and_exam_management.ExamEntry, sign_in_and_exam_management.Student" %>
<%
    List<ExamEntry> examList = (List<ExamEntry>) request.getAttribute("examList");
    String studentId = (String) request.getAttribute("studentId");

    Student student = (Student) session.getAttribute("student");
    String userFirstName = student != null ? student.getFirstName() : "User";
    int index = 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Exams</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        body {
            padding-top: 50px;
            overflow-x: hidden;
            font-family: "Poppins", sans-serif;
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
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 40px;
            background-color: #3b4a68;
            color: white;
            text-align: center;
            line-height: 40px;
            font-size: 14px;
            font-family: "Poppins", sans-serif;
            z-index: 1000;
        }

        .container {

            max-width: 1000px;
            margin: 100px auto 60px;
            padding: 30px 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(128, 0, 255, 0.05);
        }

        h1 {
            color: #3b4a68;
            margin-bottom: 30px;
        }

        .reload-button {
            text-align: right;
            margin-bottom: 10px;
        }

        .reload-button button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .reload-button button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #e7ecf4;
            color: #3b4a68;
        }

        tbody tr:hover {
            background-color: #f0f4f8;
        }

        button.take-btn {
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button.take-btn:hover {
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
    <h1><i data-lucide="file-text"></i> Available Exams</h1>

    <div class="reload-button">
        <button onclick="location.reload()">
            <i data-lucide="refresh-cw"></i> Reload
        </button>
    </div>

    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Exam Name</th>
            <th>Course</th>
            <th>Lecturer</th>
            <th>Number of Questions</th>
            <th>Date & Time</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% if (examList != null && !examList.isEmpty()) {
            for (ExamEntry exam : examList) {
        %>
        <tr>
            <td><%= index++ %></td>
            <td><%= exam.getSubject() %> Exam</td>
            <td><%= exam.getSubject() %></td>
            <td><%= exam.getLecturer() %></td>
            <td><%= exam.getQuestionCount() %></td>
            <td><%= exam.getDate() %> (<%= exam.getTime() %>)</td>
            <td>
                <form action="LoadExamServlet" method="get">
                    <input type="hidden" name="examId" value="<%= exam.getFileName() %>">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <button type="submit" class="take-btn">
                        <i data-lucide="edit-3"></i> Take Exam
                    </button>
                </form>
            </td>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="7" style="text-align: center;">No available exams found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- ✅ Footer -->
<div class="footer">
    &copy; project_group_198 &nbsp; All rights reserved
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();

    setInterval(() => location.reload(), 30000);

    document.getElementById("menuBtn").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    });
</script>

</body>
</html>
