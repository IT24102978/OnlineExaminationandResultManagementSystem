package com.example.onlineexamsystem.model;

public class Question {
    private String id;
    private String type;
    private String topic;
    private String subject;
    private String text;
    private String options;
    private String correctAnswer;

    public Question(String id, String type, String topic, String subject, String text, String options, String correctAnswer) {
        this.id = id;
        this.type = type;
        this.topic = topic;
        this.subject = subject;
        this.text = text;
        this.options = options;
        this.correctAnswer = correctAnswer;
    }

    public String getId() { return id; }
    public String getType() { return type; }
    public String getTopic() { return topic; }
    public String getSubject() { return subject; }
    public String getText() { return text; }
    public String getOptions() { return options; }
    public String getCorrectAnswer() { return correctAnswer; }

    @Override
    public String toString() {
        return id + "," + type + "," + topic + "," + subject + "," + text + "," + options + "," + correctAnswer;
    }
}