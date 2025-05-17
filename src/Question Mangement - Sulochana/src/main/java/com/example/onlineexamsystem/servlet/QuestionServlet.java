package com.example.onlineexamsystem.servlet;

import com.example.onlineexamsystem.Service.QuestionFileHandler;
import com.example.onlineexamsystem.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/questions/*")
public class QuestionServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        String contextPath = getServletContext().getRealPath("/");
        QuestionFileHandler.initFilePath(contextPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || "/".equals(pathInfo)) {
            List<Question> questions = QuestionFileHandler.readQuestions();
            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/WEB-INF/views/question_bank.jsp").forward(request, response);
        } else if (pathInfo.equals("/add")) {
            request.getRequestDispatcher("/WEB-INF/views/add_question.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            String id = pathInfo.substring(6);
            List<Question> questions = QuestionFileHandler.readQuestions();
            Question question = questions.stream().filter(q -> q.getId().equals(id)).findFirst().orElse(null);
            request.setAttribute("question", question);
            request.getRequestDispatcher("/WEB-INF/views/edit_question.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String method = request.getParameter("_method");
        if ("DELETE".equalsIgnoreCase(method) && pathInfo != null && pathInfo.startsWith("/delete/")) {
            String id = pathInfo.substring(8);
            QuestionFileHandler.deleteQuestion(id);
            response.sendRedirect(request.getContextPath() + "/questions");
        } else if ("/save".equals(pathInfo)) {
            String id = String.valueOf(System.currentTimeMillis());
            String type = request.getParameter("type") != null ? request.getParameter("type") : "";
            String topic = request.getParameter("topic") != null ? request.getParameter("topic") : "";
            String subject = request.getParameter("subject") != null ? request.getParameter("subject") : "";
            String text = request.getParameter("text") != null ? request.getParameter("text") : "";
            String options = request.getParameter("options") != null ? request.getParameter("options") : "";
            String correctAnswer = request.getParameter("correctAnswer") != null ? request.getParameter("correctAnswer") : "";
            Question question = new Question(id, type, topic, subject, text, options, correctAnswer);
            QuestionFileHandler.writeQuestion(question);
            response.sendRedirect(request.getContextPath() + "/questions");
        } else if ("/update".equals(pathInfo)) {
            String id = request.getParameter("id");
            QuestionFileHandler.deleteQuestion(id);
            String type = request.getParameter("type") != null ? request.getParameter("type") : "";
            String topic = request.getParameter("topic") != null ? request.getParameter("topic") : "";
            String subject = request.getParameter("subject") != null ? request.getParameter("subject") : "";
            String text = request.getParameter("text") != null ? request.getParameter("text") : "";
            String options = request.getParameter("options") != null ? request.getParameter("options") : "";
            String correctAnswer = request.getParameter("correctAnswer") != null ? request.getParameter("correctAnswer") : "";
            Question updatedQuestion = new Question(id, type, topic, subject, text, options, correctAnswer);
            QuestionFileHandler.writeQuestion(updatedQuestion);
            response.sendRedirect(request.getContextPath() + "/questions");
        }
    }
}