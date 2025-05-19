package result_management;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import result_management.controllers.resultController;

import java.io.IOException;

@WebServlet("/submitUpdateResult")
public class submitUpdateResult extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String RESULT_FILE_PATH = request.getServletContext().getRealPath("data/results.txt");



        String subjectCode = request.getParameter("subjectCode");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String Marks = request.getParameter("Marks");

        String grade = request.getParameter("grade");

        resultController resultController = new resultController(RESULT_FILE_PATH);
        boolean updated = resultController.updateResult(subjectCode, studentName, subject, Marks, grade);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/result");
        } else {
            response.getWriter().println("Error: Record not found or could not be updated.");
        }
}
}
