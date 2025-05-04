package com.example.oop_project;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.ArrayList;

public class SubmitExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Retrieve exam data from session
        ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
        String examId = (String) session.getAttribute("examId");
        String studentId = (String) session.getAttribute("studentId");

        // Validate
        if (mcqList == null || examId == null || studentId == null) {
            response.getWriter().println("Session expired or missing data.");
            return;
        }

        // Record user answers
        for (int i = 0; i < mcqList.size(); i++) {
            String answer = request.getParameter("q" + i);
            mcqList.get(i).setUserAnswer(answer);
        }

        // File path to save answers
        String folderPath = "C:/Users/VICTUS/Documents/ExamSystem/StudentAnswer/";
        String fileName = studentId + "_" + examId + "_answers";
        String filePath = folderPath + fileName;

        // Ensure folder exists
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        // Save answers to file
        MCQService service = new MCQService();
        service.saveUserAnswers(mcqList, filePath);

        System.out.println("✅ Answer file saved at: " + filePath);

        // ✅ Create submission marker
        String submissionMarkerPath = "C:/Users/VICTUS/Documents/ExamSystem/Submissions/";
        File submissionFolder = new File(submissionMarkerPath);
        if (!submissionFolder.exists()) {
            submissionFolder.mkdirs();
        }

        // ❗ FIXED: Don't add ".txt" again — examId already includes it
        File marker = new File(submissionMarkerPath + studentId + "_" + examId);
        marker.createNewFile(); // empty file to mark the attempt

        // Forward to result page
        session.setAttribute("mcqList", mcqList);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
