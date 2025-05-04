package com.example.oop_project;

import java.io.*;
import java.util.ArrayList;

public class MCQService {

    public ArrayList<MCQ> loadQuestions(String filename) {
        ArrayList<MCQ> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                // Skip metadata lines
                if (line.startsWith("Lecturer:") || line.startsWith("Duration:") || line.startsWith("QuestionCount:")) {
                    continue;
                }

                // Read question and 4 options
                String question = line;
                String a = reader.readLine();
                String b = reader.readLine();
                String c = reader.readLine();
                String d = reader.readLine();

                // Skip answer line
                String answerLine = reader.readLine(); // e.g., Answer: C

                if (a != null && b != null && c != null && d != null) {
                    // Clean question
                    question = question.replaceFirst("^Q:\\s*", "").trim();
                    MCQ mcq = new MCQ(question, a.trim(), b.trim(), c.trim(), d.trim());
                    list.add(mcq);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Total questions loaded: " + list.size());
        return list;
    }



    // ✅ Save student's submitted answers
    public void saveUserAnswers(ArrayList<MCQ> list, String filename) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (int i = 0; i < list.size(); i++) {
                MCQ mcq = list.get(i);
                writer.write("Q" + (i + 1) + ": " + mcq.getQuestion());
                writer.newLine();
                writer.write("Selected Answer: " + mcq.getUserAnswer());
                writer.newLine();
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println(" Error writing answers: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
