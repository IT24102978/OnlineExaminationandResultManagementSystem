<%@ page import="java.util.List" %>
<%@ page import="sign_in_and_exam_management.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Students List - Online Examination System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #80deea);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 60px;
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .btn {
            border-radius: 8px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-warning {
            background-color: #ffb84d;
            color: #000;
            border: none;
        }

        .btn-danger {
            background-color: #ff4d4d;
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .alert {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center">Registered Students</h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger text-center"><%= request.getParameter("error") %></div>
    <% } %>

    <div class="d-flex justify-content-between mb-3">
        <a href="signup2.jsp" class="btn btn-primary">+ Add New Student</a>
        <a href="dashboard.jsp" class="btn btn-outline-primary">Back to Dashboard</a>
    </div>

    <table class="table table-hover table-bordered text-center">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Course</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Student> students = (List<Student>) session.getAttribute("students");
            if (students != null && !students.isEmpty()) {
                for (Student student : students) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getFullName() %></td>
            <td><%= student.getEmail() %></td>
            <td><%= student.getCourse() %></td>
            <td>
                <a href="StudentController?action=edit&id=<%= student.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <form action="StudentController" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5">No students found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
