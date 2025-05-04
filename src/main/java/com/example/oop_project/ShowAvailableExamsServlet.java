package com.example.oop_project;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


public class ShowAvailableExamsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = "stu122";
        if (studentId == null || studentId.isEmpty()) {
            response.getWriter().println("Student ID is required.");
            return;
        }

        String basePath = "C:/Users/VICTUS/Documents/ExamSystem"; // Your base path

        StudentDataLoader loader = new StudentDataLoader(basePath);
        List<String> subjects = loader.loadEnrolledSubjects(studentId);
        List<ExamEntry> availableExams = loader.getAvailableExams(studentId, subjects);

        request.setAttribute("examList", availableExams);
        request.setAttribute("studentId", studentId); // For passing to JSP
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}

