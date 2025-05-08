package com.example.new_result;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addResult")
public class addResult extends HttpServlet {
    private static final String STUDENT_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/students.txt";
    private static final String SUBJECTS_FILE_PATH = "D:/project/New_Result/src/main/webapp/data/subjects.txt";


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{

//            List<String[]> subjects = readSubjects();

            PrintWriter out = response.getWriter();

            out.println();
            out.println("<html><body>");



//            System.out.println("Students List Size: " + students.size()); // Debugging
//            System.out.println("Subjects List Size: " + subjects.size()); // Debugging
//
            request.setAttribute("students", student());
            request.setAttribute("subjects", subjects());
//            request.setAttribute("subjects", subjects);

            request.getRequestDispatcher("addResult.jsp").forward(request, response);
        }
        catch (Exception e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data");
        }
    }


  private List<String[]> student() throws  IOException {

      List<String[]> students = new ArrayList<>();


      try (BufferedReader br = new BufferedReader(new FileReader(STUDENT_FILE_PATH))) {
          String line;
          while ((line = br.readLine()) != null) {

              String[] student = line.split(",");

              if (student.length >= 2) {
                  students.add(student); // [0] = ID, [1] = Name

              }
          }
          return students;

      } catch (IOException e) {
          e.printStackTrace();

          return null;
      }

  }



    private List<String[]> subjects() throws  IOException {

        List<String[]> subjects = new ArrayList<>();


        try (BufferedReader br = new BufferedReader(new FileReader(SUBJECTS_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {

                String[] sub = line.split(",");

                if (sub.length >= 2) {
                    subjects.add(sub); // [0] = ID, [1] = Name

                }
            }
            return subjects;

        } catch (IOException e) {
            e.printStackTrace();

            return null;
        }

    }

}
