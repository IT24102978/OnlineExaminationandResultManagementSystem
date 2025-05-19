package feedback;

import java.util.List;

public class FeedbackDataService {

    public static List<Feedback> getAllFeedback() {

        return FeedbackServlet.feedbackList;
    }
}
