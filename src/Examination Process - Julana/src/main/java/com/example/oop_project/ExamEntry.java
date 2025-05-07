package com.example.oop_project;

import java.time.LocalDate;
import java.time.LocalTime;

public class ExamEntry {
    private String subject;
    private String lecturer;
    private int questionCount;
    private LocalDate date;
    private LocalTime time;
    private String fileName;

    public ExamEntry(String subject, String lecturer, int questionCount,
                     LocalDate date, LocalTime time, String fileName) {
        this.subject = subject;
        this.lecturer = lecturer;
        this.questionCount = questionCount;
        this.date = date;
        this.time = time;
        this.fileName = fileName;
    }

    public String getSubject() {
        return subject;
    }

    public String getLecturer() {
        return lecturer;
    }

    public int getQuestionCount() {
        return questionCount;
    }

    public LocalDate getDate() {
        return date;
    }

    public LocalTime getTime() {
        return time;
    }

    public String getFileName() {
        return fileName;
    }

    @Override
    public String toString() {
        return subject + " on " + date + " at " + time + " (" + questionCount + " questions)";
    }
}
