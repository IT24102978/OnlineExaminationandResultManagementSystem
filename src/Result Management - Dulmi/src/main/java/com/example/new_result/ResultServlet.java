package com.example.new_result;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {
    private static  String FILE_PATH = "D:/project/New_Result/src/main/webapp/data/results.txt";

//    final String FILE_PATH = getServletContext().getRealPath("/results.txt");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<String[]> results = readResultsFromFile();
        request.setAttribute("results", results);
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }

    private List<String[]> readResultsFromFile() throws IOException {
        List<String[]> results = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                results.add(line.split(","));
            }
        }
        return results;
    }
}
