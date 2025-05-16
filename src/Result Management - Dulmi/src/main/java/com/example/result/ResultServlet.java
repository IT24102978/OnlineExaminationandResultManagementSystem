package com.example.result;

import java.io.*;
import java.util.*;

import controllers.resultController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

        resultController rscontroller = new resultController(FILE_PATH);

        List<String[]> results = rscontroller.readResultsFromFile();

        request.setAttribute("results", results);
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }
}
