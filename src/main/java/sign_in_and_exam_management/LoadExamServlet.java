package sign_in_and_exam_management;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class LoadExamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String examId = request.getParameter("examId");
        String studentId = request.getParameter("studentId");

        if (examId == null || examId.trim().isEmpty()) {
            response.getWriter().println("No exam selected.");
            return;
        }

        String basePath = getServletContext().getRealPath("/victus");
        String filePath = basePath + "/Exams/" + examId;
        File file = new File(filePath);
        if (!file.exists()) {
            response.getWriter().println("Exam file not found for: " + examId);
            return;
        }


        MCQService service = new MCQService(getServletContext());
        ArrayList<MCQ> mcqList = service.loadQuestions(filePath);
        if (mcqList == null || mcqList.isEmpty()) {
            response.getWriter().println("No questions found in exam: " + examId);
            return;
        }


        int duration = 60;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Duration:")) {
                    duration = Integer.parseInt(line.substring(9).trim());
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println(" Couldn't parse duration, using default 60 minutes.");
        }


        HttpSession session = request.getSession();
        session.setAttribute("mcqList", mcqList);
        session.setAttribute("examId", examId);
        session.setAttribute("studentId", studentId);
        session.setAttribute("examDuration", duration);


        request.getRequestDispatcher("exam.jsp").forward(request, response);
    }
}
