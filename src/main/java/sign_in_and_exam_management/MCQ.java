package sign_in_and_exam_management;

public class MCQ {
    private String question;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String userAnswer;
    private String correctAnswer;

    public MCQ(String question, String a, String b, String c, String d, String correctAnswer) {
        this.question = question;
        this.optionA = a;
        this.optionB = b;
        this.optionC = c;
        this.optionD = d;
        this.correctAnswer = correctAnswer;
    }

    public String getQuestion() {
        return question;
    }
    public String getOptionA() {
        return optionA;
    }
    public String getOptionB() {
        return optionB;
    }
    public String getOptionC() {
        return optionC;
    }
    public String getOptionD() {
        return optionD;
    }
    public String getUserAnswer() {
        return userAnswer;
    }
    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public String getCorrectAnswer() {   // ✅ New getter
        return correctAnswer;
    }
    public void setCorrectAnswer(String correctAnswer) {  // ✅ Optional setter
        this.correctAnswer = correctAnswer;
    }
}
