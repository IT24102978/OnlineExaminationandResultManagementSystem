<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.oop_project.ExamEntry" %>
<%
    List<ExamEntry> examList = (List<ExamEntry>) request.getAttribute("examList");
    String studentId = (String) request.getAttribute("studentId");
    int index = 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Exams</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f6ff;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(128, 0, 255, 0.05);
        }

        h1 {
            color: #5c3d99;
            margin-bottom: 30px;
        }

        .reload-button {
            text-align: right;
            margin-bottom: 10px;
        }

        .reload-button button {
            background-color: #5c3d99;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .reload-button button:hover {
            background-color: #4a2c82;
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
            background-color: #f0e7ff;
            color: #5c3d99;
        }

        tbody tr:hover {
            background-color: #f7f1ff;
        }

        button.take-btn {
            background-color: #5c3d99;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button.take-btn:hover {
            background-color: #4a2c82;
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

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();
    setInterval(() => location.reload(), 30000);
</script>

</body>
</html>
