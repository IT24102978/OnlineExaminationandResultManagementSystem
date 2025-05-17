package com.example.onlineexamsystem.Service;

import com.example.onlineexamsystem.model.Question;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionFileHandler {
    private static String FILE_PATH;

    public static void initFilePath(String contextPath) {
        FILE_PATH = "C:\\Users\\chama\\OneDrive\\Desktop\\Last Project\\OnlineExamManegement\\src\\data\\question.txt";
        System.out.println("Initialized FILE_PATH: " + FILE_PATH);
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                // Create the parent directories if they don't exist
                file.getParentFile().mkdirs();
                file.createNewFile();
                System.out.println("Created new question.txt at: " + FILE_PATH);
            } catch (IOException e) {
                System.out.println("Error creating question.txt: " + e.getMessage());
            }
        }
    }

    public static List<Question> readQuestions() throws IOException {
        List<Question> questions = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 7);
                if (parts.length == 7) {
                    questions.add(new Question(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]));
                }
            }
        }
        return questions;
    }

    public static void writeQuestion(Question question) throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(question.toString());
            writer.newLine();
        }
    }

    public static void deleteQuestion(String id) throws IOException {
        List<Question> questions = readQuestions();
        questions.removeIf(q -> q.getId().equals(id));
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Question q : questions) {
                writer.write(q.toString());
                writer.newLine();
            }
        }
    }
}