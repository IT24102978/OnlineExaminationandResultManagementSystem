<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Students List - Online Examination System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Students List</h2>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>
    <a href="signup.jsp" class="btn btn-primary mb-3">Add New Student</a>
    <table class="table table-bordered">
        <thead>
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
            List<Student> students = (List<Student>) request.getAttribute("students");
            if (students != null) {
                for (Student student : students) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getFullName() %></td>
            <td><%= student.getEmail() %></td>
            <td><%= student.getCourse() %></td>
            <td>
                <a href="StudentController?action=view&id=<%= student.getId() %>" class="btn btn-info btn-sm">View</a>
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
            }
        %>
        </tbody>
    </table>
    <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>