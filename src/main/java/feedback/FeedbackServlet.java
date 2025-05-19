package feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Initialize the feedback list
    public static List<Feedback> feedbackList = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        if (comments != null && !comments.trim().isEmpty()) {
            Feedback feedback = new Feedback(
                    feedbackList.size() + 1,
                    studentId,
                    name,
                    email,
                    comments,
                    rating
            );
            feedbackList.add(feedback);
        }

        // Forward to confirmation page
        request.getRequestDispatcher("feedbackSuccess.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Calculate rating stats
        Map<Integer, Integer> ratingCounts = new HashMap<>();
        double totalRating = 0;
        int count = 0;

        for (Feedback fb : feedbackList) {
            int rate = fb.getRating();
            ratingCounts.put(rate, ratingCounts.getOrDefault(rate, 0) + 1);
            totalRating += rate;
            count++;
        }

        double averageRating = (count > 0) ? (totalRating / count) : 0;

        request.setAttribute("reviews", feedbackList);
        request.setAttribute("ratingCounts", ratingCounts);
        request.setAttribute("averageRating", averageRating);
        request.getRequestDispatcher("feedback_dashboard.jsp").forward(request, response);
    }
}
