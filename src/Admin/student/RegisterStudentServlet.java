package student;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/register")
public class RegisterStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String course = req.getParameter("course");
        String type = req.getParameter("type");

        Student student = "Scholarship".equalsIgnoreCase(type)
            ? new ScholarshipStudent(id, name, email, course)
            : new RegularStudent(id, name, email, course);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:/exam-system/students.txt", true))) {
            writer.write(student.toCSV() + "," + type);
            writer.newLine();
        }

        res.setContentType("text/html");
        res.getWriter().println("Student registered successfully.");
    }
}
