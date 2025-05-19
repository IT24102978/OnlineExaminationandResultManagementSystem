package sign_in_and_exam_management;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class SubmitExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();


        ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
        String examId = (String) session.getAttribute("examId");
        String studentId = (String) session.getAttribute("studentId");

        if (mcqList == null || examId == null || studentId == null) {
            response.getWriter().println("Session expired or missing data.");
            return;
        }


        for (int i = 0; i < mcqList.size(); i++) {
            String answer = request.getParameter("q" + i);
            mcqList.get(i).setUserAnswer(answer);
        }


        MCQService service = new MCQService(getServletContext());
        int score = service.calculateScore(mcqList);


        service.saveUserScore(studentId, examId, score, mcqList.size());

        String basePath = getServletContext().getRealPath("/victus");
        String submissionMarkerPath = basePath + "/Submissions";
        File submissionFolder = new File(submissionMarkerPath);
        if (!submissionFolder.exists()) {
            submissionFolder.mkdirs();
        }

        File marker = new File(submissionMarkerPath + studentId + "_" + examId);
        marker.createNewFile();

        // Send score to the dedicated score.jsp
        session.setAttribute("score", score);
        session.setAttribute("total", mcqList.size());
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}

