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

@WebServlet("/deleteResult")
public class DeleteResultServlet extends HttpServlet {
    private static final String RESULT_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/results.txt";  // Update with correct path

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String subjectCode = request.getParameter("subjectCode");

        // Read the results from the file into a list
        List<String> results = new ArrayList<>();
        BufferedReader reader = null;

        try {
            reader = new BufferedReader(new FileReader(RESULT_FILE_PATH));
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                System.out.println(studentId);
                System.out.println(data[1]);

                if (!(data[0].equals(studentId) && data[1].equals(subjectCode))) {
                    results.add(line);
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

        // If the studentId and subjectCode were found and removed, rewrite the file
        if (results.size() > 0) {
            try (PrintWriter writer = new PrintWriter(new FileWriter(RESULT_FILE_PATH))) {
                // Write the remaining results back to the file
                for (String result : results) {
                    writer.println(result);
                }
            } catch (IOException e) {
                e.printStackTrace();
                response.getWriter().println("Error: Unable to write to the file.");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/result");  // Redirect to the result page
        } else {
            response.getWriter().println("Error: Record not found.");
        }
    }
}

