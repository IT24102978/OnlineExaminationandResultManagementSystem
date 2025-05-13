package com.example.result;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deleteResult")
public class DeleteResultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String RESULT_FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");

        List<String> results = new ArrayList<>();
        boolean recordFound = false;
        BufferedReader reader = null;

        try {
            reader = new BufferedReader(new FileReader(RESULT_FILE_PATH));
            String line;

            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (!(data[0].equals(studentId) && data[1].equals(subjectCode))) {
                    results.add(line);
                } else {
                    recordFound = true; // Match found, do not add to the list
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("Error: Unable to read the file.");
            return;
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        if (recordFound) {
            try (PrintWriter writer = new PrintWriter(new FileWriter(RESULT_FILE_PATH))) {
                for (String result : results) {
                    writer.println(result);
                }
            } catch (IOException e) {
                e.printStackTrace();
                response.getWriter().println("Error: Unable to write to the file.");
                return;
            }
            // Redirect to result page after successful deletion
            response.sendRedirect(request.getContextPath() + "/result");
        } else {
            // Record not found
            response.getWriter().println("Error: Record not found.");
        }
    }
}
