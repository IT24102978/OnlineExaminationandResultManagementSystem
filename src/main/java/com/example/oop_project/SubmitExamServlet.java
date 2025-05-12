package com.example.oop_project;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class SubmitExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Retrieve exam session data
        ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
        String examId = (String) session.getAttribute("examId");
        String studentId = (String) session.getAttribute("studentId");

        if (mcqList == null || examId == null || studentId == null) {
            response.getWriter().println("Session expired or missing data.");
            return;
        }

        // Collect student's selected answers
        for (int i = 0; i < mcqList.size(); i++) {
            String answer = request.getParameter("q" + i);
            mcqList.get(i).setUserAnswer(answer);
        }

        // Calculate score using MCQService
        MCQService service = new MCQService();
        int score = service.calculateScore(mcqList);

        // Save the score to a file
        service.saveUserScore(studentId, examId, score, mcqList.size());

        // Create submission marker file
        String submissionMarkerPath = "C:/Users/VICTUS/Documents/ExamSystem/Submissions/";
        File submissionFolder = new File(submissionMarkerPath);
        if (!submissionFolder.exists()) {
            submissionFolder.mkdirs();
        }

        File marker = new File(submissionMarkerPath + studentId + "_" + examId);
        marker.createNewFile();

        // Send score to the dedicated score.jsp
        session.setAttribute("score", score);
        session.setAttribute("total", mcqList.size());
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}

