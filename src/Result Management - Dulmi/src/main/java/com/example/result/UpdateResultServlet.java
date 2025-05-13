package com.example.result;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateResult")
public class UpdateResultServlet extends HttpServlet {
//    private static final String RESULT_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt"; // Path to your result file

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String RESULT_FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

        // Get the studentId and subjectCode from the request
        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");

        // Read the result file and find the matching record
        String[] resultData = null;

        try (BufferedReader reader = new BufferedReader(new FileReader(RESULT_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                // Check if the studentId and subjectCode match
                if (data.length >= 7 && data[0].equals(studentId) && data[1].equals(subjectCode)) {
                    resultData = data;
                    break; // Found the record, no need to continue reading
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("Error reading the result file.");
            return;
        }

        // If the record was found, set attributes and forward to update form
        if (resultData != null) {
            request.setAttribute("studentId", studentId);
            request.setAttribute("subjectCode", subjectCode);
            request.setAttribute("studentName", resultData[0]);
            request.setAttribute("subject", resultData[2]);
            request.setAttribute("credits", resultData[3]);
            request.setAttribute("ca", resultData[4]);
            request.setAttribute("attempt", resultData[5]);
            request.setAttribute("grade", resultData[6]);

            // Forward to the update form JSP
            request.getRequestDispatcher("updateResultForm.jsp").forward(request, response);
        } else {
            // If the record was not found, show an error
            response.getWriter().println("Error: Record not found.");
        }
    }
}
