package com.example.result;

import java.io.*;

import controllers.resultController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/submitUpdateResult")
public class submitUpdateResult extends HttpServlet {

//    private static final String RESULT_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String RESULT_FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");

        String[] resultData = null;

        try (BufferedReader reader = new BufferedReader(new FileReader(RESULT_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data[0].equals(studentId) && data[1].equals(subjectCode)) {
                    resultData = data;
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (resultData != null) {
            request.setAttribute("studentId", resultData[0]);
            request.setAttribute("subjectCode", resultData[1]);
            request.setAttribute("studentName", resultData[1]); // if student name is in data[1]
            request.setAttribute("subject", resultData[2]);
            request.setAttribute("credits", resultData[3]);
            request.setAttribute("ca", resultData[4]);
            request.setAttribute("attempt", resultData[5]);
            request.setAttribute("grade", resultData[6]);

            request.getRequestDispatcher("updateResultForm.jsp").forward(request, response);
        } else {
            response.getWriter().println("Error: Record not found.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String RESULT_FILE_PATH = request.getServletContext().getRealPath("data/results.txt");


        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String credits = request.getParameter("credits");
//        String ca = request.getParameter("ca");
        String attempt = request.getParameter("attempt");
        String grade = request.getParameter("grade");

        resultController resultController = new resultController(RESULT_FILE_PATH);
        boolean updated = resultController.updateResult( studentId, subjectCode, studentName, subject, credits, attempt, grade);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/result");
        } else {
            response.getWriter().println("Error: Record not found or could not be updated.");
        }
}
}
