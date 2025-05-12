package com.example.demo;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class StudentController extends HttpServlet {
    private StudentManager studentManager;

    @Override
    public void init() {
        studentManager = (StudentManager) getServletContext().getAttribute("studentManager");
        if (studentManager == null) {
            studentManager = new StudentManager();
            getServletContext().setAttribute("studentManager", studentManager);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("signup".equals(action)) {
            String id = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String course = request.getParameter("course");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                response.sendRedirect("signup.jsp?error=Passwords do not match");
                return;
            }

            if (studentManager.searchStudentById(id) != null) {
                response.sendRedirect("signup.jsp?error=Student ID already exists");
                return;
            }

            if (id != null && firstName != null && lastName != null && email != null && course != null && password != null) {
                Student student = new Student(id, firstName, lastName, email, course, password);
                studentManager.addStudent(student);
                response.sendRedirect("studentLogin.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=Invalid input");
            }
        } else if ("login".equals(action)) {
            String id = request.getParameter("id");
            String password = request.getParameter("password");

            Student student = studentManager.searchStudentById(id);
            if (student != null && student.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("student", student);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("studentLogin.jsp?error=Invalid ID or password");
            }
        } else if ("update".equals(action)) {
            String id = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String course = request.getParameter("course");

            if (id != null && firstName != null && lastName != null && email != null && course != null) {
                boolean updated = studentManager.updateStudent(id, firstName, lastName, email, course);
                if (updated) {
                    response.sendRedirect("StudentController?action=getStudents");
                } else {
                    response.sendRedirect("editStudent.jsp?id=" + id + "&error=Update failed");
                }
            } else {
                response.sendRedirect("editStudent.jsp?id=" + id + "&error=Invalid input");
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                boolean deleted = studentManager.deleteStudentById(id);
                if (deleted) {
                    response.sendRedirect("StudentController?action=getStudents");
                } else {
                    response.sendRedirect("students.jsp?error=Delete failed");
                }
            } else {
                response.sendRedirect("students.jsp?error=Invalid ID");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("getStudents".equals(action)) {
            List<Student> students = studentManager.getAllStudents();
            request.setAttribute("students", students);
            RequestDispatcher dispatcher = request.getRequestDispatcher("students.jsp");
            dispatcher.forward(request, response);
        } else if ("view".equals(action)) {
            if (id != null) {
                Student student = studentManager.searchStudentById(id);
                request.setAttribute("student", student);
                RequestDispatcher dispatcher = request.getRequestDispatcher("studentProfile.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("students.jsp?error=Invalid ID");
            }
        } else if ("edit".equals(action)) {
            if (id != null) {
                Student student = studentManager.searchStudentById(id);
                request.setAttribute("student", student);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editStudent.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("students.jsp?error=Invalid ID");
            }
        }
    }
}