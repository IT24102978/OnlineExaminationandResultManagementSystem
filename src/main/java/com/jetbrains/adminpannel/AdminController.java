package com.jetbrains.adminpannel;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class AdminController extends HttpServlet {

    private Map<String, String> loadUserCredentials() throws IOException {
        Map<String, String> users = new HashMap<>();

        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/users.txt");
        if (input == null) {
            throw new FileNotFoundException("users.txt not found in /WEB-INF/");
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(input));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(":");
            if (parts.length == 2) {
                users.put(parts[0].trim(), parts[1].trim());
            }
        }
        return users;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Map<String, String> users = loadUserCredentials();

            if (users.containsKey(username) && users.get(username).equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("adminUser", username);

                // Redirect based on prefix
                if (username.startsWith("A")) {
                    response.sendRedirect("index.jsp");
                } else if (username.startsWith("T")) {
                    response.sendRedirect("teacherDashboard.jsp");
                } else if (username.startsWith("S")) {
                    response.sendRedirect("studentDashboard.jsp");
                } else {
                    response.sendRedirect("unknownRole.jsp");
                }
            } else {
                response.sendRedirect("adminLogin.jsp?error=Invalid+credentials");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}