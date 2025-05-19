<%@ page import="java.io.*, package com.jetbrains.adminpannel;" %>
<%
    if (session != null && session.getAttribute("adminUser") != null) {
        response.sendRedirect("adminControl.jsp");
        return;
    }

    String errorMessage = "";
    String successMessage = "";

    String adminFilePath = application.getRealPath("/WEB-INF/data/users.txt");
    String nextAdminId = AdminIdGenerator.getNextAdminId(adminFilePath);

    if (request.getMethod().equalsIgnoreCase("post")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty()) {
            errorMessage = "Username is required";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Password is required";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match";
        } else {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(adminFilePath, true))) {
                writer.write(username + ",,,,,," + password);
                writer.newLine();
                successMessage = "Admin account created successfully!";
            } catch (IOException e) {
                errorMessage = "Error writing to file.";
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Admin</title>
</head>
<body>
<% if (!errorMessage.isEmpty()) { %>
<p style="color:red;"><%= errorMessage %></p>
<% } %>

<% if (!successMessage.isEmpty()) { %>
<p style="color:green;"><%= successMessage %></p>
<% } %>

<form method="post">
    <label>Username:</label>
    <input type="text" name="username" value="<%= nextAdminId %>" readonly /><br/>
    <label>Password:</label>
    <input type="password" name="password" /><br/>
    <label>Confirm Password:</label>
    <input type="password" name="confirmPassword" /><br/>
    <button type="submit">Register Admin</button>
</form>
</body>
</html>