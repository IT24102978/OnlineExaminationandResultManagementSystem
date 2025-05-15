package com.example.oop_project_analysis;

public class Feedback {
    private int feedbackId;
    private String studentId;
    private String name;
    private String email;
    private String comments;
    private int rating;

    // Constructor
    public Feedback(int feedbackId, String studentId, String name, String email, String comments, int rating) {
        this.feedbackId = feedbackId;
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.comments = comments;
        this.rating = rating;
    }

    // Getters
    public int getFeedbackId() {
        return feedbackId;
    }

    public String getStudentId() {
        return studentId;
    }
    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getComments() {
        return comments;
    }

    public int getRating() {
        return rating;
    }


    // Setters
    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}

