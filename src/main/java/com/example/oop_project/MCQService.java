package com.example.oop_project;



import java.io.*;
import java.util.ArrayList;

public class MCQService {

    public ArrayList<MCQ> loadQuestions(String filename) {
        ArrayList<MCQ> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Lecturer:") || line.startsWith("Duration:") || line.startsWith("QuestionCount:")) {
                    continue;
                }

                String question = line;
                String a = reader.readLine();
                String b = reader.readLine();
                String c = reader.readLine();
                String d = reader.readLine();
                String answerLine = reader.readLine();

                if (a != null && b != null && c != null && d != null && answerLine != null) {
                    question = question.replaceFirst("^Q:\\s*", "").trim();
                    String correctAnswer = answerLine.replaceFirst("^Answer:\\s*", "").trim();
                    MCQ mcq = new MCQ(question, a.trim(), b.trim(), c.trim(), d.trim(), correctAnswer);
                    list.add(mcq);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return list;
    }

    // ✅ Calculate total score
    public int calculateScore(ArrayList<MCQ> list) {
        int score = 0;
        for (MCQ mcq : list) {
            if (mcq.getUserAnswer() != null &&
                    mcq.getUserAnswer().equalsIgnoreCase(mcq.getCorrectAnswer())) {
                score++;
            }
        }
        return score;
    }

    // ✅ Save only the score to a text file
    public void saveUserScore(String studentId, String examId, int score, int total) {
        String folderPath = "C:/Users/VICTUS/Documents/ExamSystem/StudentScores/";
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        String filePath = folderPath + studentId + "_" + examId + "_score.txt";
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write("Student ID: " + studentId);
            writer.newLine();
            writer.write("Exam ID: " + examId);
            writer.newLine();
            writer.write("Score: " + score + " / " + total);
        } catch (IOException e) {
            System.out.println("Error saving score: " + e.getMessage());
        }
    }
}

