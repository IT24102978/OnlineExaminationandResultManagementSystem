package com.example.msdulmi;

import java.io.*;
import java.util.*;

import controllers.resultController;
import controllers.studentController;
import controllers.subjectController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;

import java.io.FileWriter;
import java.io.IOException;

@WebServlet("/submitResultServlet")
public class submitResultServlet extends HttpServlet {

//    private static final String FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";
//    private static final String STUDENT_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/students.txt";
//    private static final String SUB_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/subjects.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        String FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";
        String FILE_PATH = request.getServletContext().getRealPath("data/results.txt");
        String STUDENT_FILE_PATH = request.getServletContext().getRealPath("data/students.txt");
        String SUB_FILE_PATH = request.getServletContext().getRealPath("data/subjects.txt");


        // Get form data
        String studentId = request.getParameter("studentName"); // This is the student ID
        String subjectCode = request.getParameter("subjectCode");
//        String subject = request.getParameter("subject");
        String credits = request.getParameter("credits");
//        String ca = request.getParameter("ca");
        String attempt = request.getParameter("attempt");
        String grade = request.getParameter("grade");

        // Get the student name using the ID

        studentController scontroller = new studentController();
        resultController rsController = new resultController();
        subjectController scController = new subjectController();

        List<String[]> students = scontroller.readStudents(STUDENT_FILE_PATH);
        String studentName = scontroller.getStudentNameById(students, studentId);

        List<String[]> sub = scController.readSub(SUB_FILE_PATH);
        String subName = scController.subNameById(sub, subjectCode);


        // Handle if student name is not found
        if (studentName == null) {
            response.getWriter().println("<p style='color:red;'>Student not found!</p>");
            return;
        }

        // Prepare data to be written to the results file
        String data = studentName + ","  + subjectCode + "," + subName + "," + credits + "," + "," + attempt + "," + grade + "\n";
        rsController.writeResult(FILE_PATH, data);


        // Redirect to the results page
        response.sendRedirect(request.getContextPath() + "/result");
    }

    // Method to read students from the file







}
