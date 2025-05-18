<%@ page import="com.example.demo.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #80deea); /* Matching students.jsp */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            background-color: #ffffffcc; /* Slightly transparent white for softness */
            padding: 30px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }

        .btn-secondary {
            border-radius: 8px;
            padding: 10px 20px;
        }

        h2 {
            font-weight: 600;
            color: #333;
        }

        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container py-5 d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="col-md-8 col-lg-6">
        <div class="card">
            <h2 class="text-center mb-4">Edit Student Information</h2>

            <%
                Student student = (Student) session.getAttribute("student");
                if (student == null) {
            %>
            <div class="alert alert-danger text-center">No student selected to edit.</div>
            <%
            } else {
            %>
            <form action="StudentController" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= student.getId() %>">

                <div class="mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName"
                           value="<%= student.getFirstName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName"
                           value="<%= student.getLastName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email"
                           value="<%= student.getEmail() %>" required>
                </div>

                <div class="mb-4">
                    <label for="course" class="form-label">Course</label>
                    <input type="text" class="form-control" id="course" name="course"
                           value="<%= student.getCourse() %>" required>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="submit" class="btn btn-primary">Update</button>
                    <a href="StudentController?action=getStudents" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
