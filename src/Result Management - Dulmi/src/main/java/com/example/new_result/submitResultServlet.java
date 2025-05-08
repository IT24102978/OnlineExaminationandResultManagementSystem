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

@WebServlet("/submitResultServlet")
public class submitResultServlet extends HttpServlet {

    private static final String FILE_PATH = "D:/project/New_Result/src/main/webapp/data/results.txt";
    private static final String STUDENT_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/students.txt";
    private static final String SUB_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/subjects.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        final String FILE_PATH = getServletContext().getRealPath("/results.txt");
        // Get form data
        String studentId = request.getParameter("studentName"); // This is the student ID
        String subjectCode = request.getParameter("subjectCode");
//        String subject = request.getParameter("subject");
        String credits = request.getParameter("credits");
//        String ca = request.getParameter("ca");
        String attempt = request.getParameter("attempt");
        String grade = request.getParameter("grade");

        // Get the student name using the ID
        List<String[]> students = readStudents();
        String studentName = getStudentNameById(students, studentId);

        List<String[]> sub = readSub();
        String subName = subNameById(sub, subjectCode);


        // Handle if student name is not found
        if (studentName == null) {
            response.getWriter().println("<p style='color:red;'>Student not found!</p>");
            return;
        }

        // Prepare data to be written to the results file
        String data = studentName + ","  + subjectCode + "," + subName + "," + credits + "," + "," + attempt + "," + grade + "\n";

        try (FileWriter fw = new FileWriter(FILE_PATH, true)) {
            fw.write(data);
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("<p style='color:red;'>Error: Could not write to file.</p>");
            return;
        }

        // Redirect to the results page
        response.sendRedirect(request.getContextPath() + "/result");
    }

    // Method to read students from the file
    private List<String[]> readStudents() {
        List<String[]> students = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(STUDENT_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] student = line.split(",");
                if (student.length >= 2) {
                    students.add(student); // [0] = ID, [1] = Name
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return students;
    }


    private List<String[]> readSub() {
        List<String[]> subject = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(SUB_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] sub = line.split(",");
                if (sub.length >= 2) {
                    subject.add(sub); // [0] = ID, [1] = Name
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return subject;
    }


    // Method to get the student name by student ID
    private String getStudentNameById(List<String[]> students, String studentId) {
        for (String[] student : students) {
            if (student[0].equals(studentId)) { // student[0] is ID
                return student[1]; // student[1] is Name
            }
        }
        return null; // Return null if student ID not found
    }

    private String subNameById(List<String[]> subjects, String studentId) {
        for (String[] sub : subjects) {
            if (sub[0].equals(studentId)) { // student[0] is ID
                return sub[1]; // student[1] is Name
            }
        }
        return null; // Return null if student ID not found
    }
}
