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
//    private static  String FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";

//    final String FILE_PATH = getServletContext().getRealPath("/results.txt");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

//        request.setAttribute("results", readResultsFromFile(FILE_PATH));

        resultController rscontroller = new resultController();

        List<String[]> results = rscontroller.readResultsFromFile(FILE_PATH);
        request.setAttribute("results", results);
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }


}
