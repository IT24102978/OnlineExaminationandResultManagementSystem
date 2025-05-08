package com.example.new_result;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;

import java.io.FileWriter;
import java.io.IOException;

@WebServlet("/updateResult")
public class UpdateResultServlet extends HttpServlet {
    private static final String RESULT_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/results.txt"; // Path to your result file

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the updated result data from the form
        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String credits = request.getParameter("credits");
//        String ca = request.getParameter("ca");
        String attempt = request.getParameter("attempt");
        String grade = request.getParameter("grade");

        // Read the file, update the matching record, and rewrite the file
        List<String> updatedResults = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(RESULT_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 7 && data[0].equals(studentId) && data[1].equals(subjectCode)) {
                    // Update the record with new values
                    line = studentId + "," + studentName + "," + subject + "," + credits + ","  + "," + attempt + "," + grade;
                    updated = true;
                }
                updatedResults.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("Error reading the result file.");
            return;
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE_PATH))) {
                for (String updatedLine : updatedResults) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
                response.getWriter().println("Result updated successfully.");
            } catch (IOException e) {
                e.printStackTrace();
                response.getWriter().println("Error writing the result file.");
            }
        } else {
            response.getWriter().println("Error: Record not found or could not be updated.");
        }
    }
}
