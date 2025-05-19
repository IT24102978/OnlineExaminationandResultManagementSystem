package sign_in_and_exam_management;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


public class ShowAvailableExamsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.isEmpty()) {
            response.getWriter().println("Student ID is required.");
            return;
        }

//        String basePath = "C:/Users/VICTUS/Documents/ExamSystem";
        String basePath = getServletContext().getRealPath("/victus");

        StudentDataLoader loader = new StudentDataLoader(basePath);
        List<String> subjects = loader.loadEnrolledSubjects(studentId);
        List<ExamEntry> availableExams = loader.getAvailableExams(studentId, subjects);

        request.setAttribute("examList", availableExams);
        request.setAttribute("studentId", studentId);
        request.getRequestDispatcher("showexam.jsp").forward(request, response);
    }
}

