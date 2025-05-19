package feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Feedback> allFeedback = FeedbackDataService.getAllFeedback();

        Map<Integer, Long> ratingCounts = allFeedback.stream()
                .collect(java.util.stream.Collectors.groupingBy(Feedback::getRating, java.util.stream.Collectors.counting()));

        double averageRating = allFeedback.stream()
                .mapToInt(Feedback::getRating)
                .average()
                .orElse(0);

        request.setAttribute("ratingCounts", ratingCounts);
        request.setAttribute("averageRating", averageRating);

        request.getRequestDispatcher("feedback_dashboard.jsp").forward(request, response);
    }
}
