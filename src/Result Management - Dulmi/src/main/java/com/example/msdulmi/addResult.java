package com.example.msdulmi;

import java.io.*;
import java.util.*;

import controllers.studentController;
import controllers.subjectController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addResult")
public class addResult extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String STUDENT_FILE_PATH = request.getServletContext().getRealPath("data/students.txt");
        String SUBJECTS_FILE_PATH = request.getServletContext().getRealPath("data/subjects.txt");

        studentController stController = new studentController();
        subjectController sController = new subjectController();

        request.setAttribute("students", stController.readStudents(STUDENT_FILE_PATH));
        request.setAttribute("subjects", sController.readSub(SUBJECTS_FILE_PATH));


        try{

            request.getRequestDispatcher("addResult.jsp").forward(request, response);
        }
        catch (Exception e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data");
        }
    }



}
