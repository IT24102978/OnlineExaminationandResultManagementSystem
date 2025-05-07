package com.example.oop_project;

import java.io.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

public class StudentDataLoader {

    private final String basePath;

    public StudentDataLoader(String basePath) {
        this.basePath = basePath;
    }

    public List<String> loadEnrolledSubjects(String studentId) throws IOException {
        File file = new File(basePath + "/Students/" + studentId + ".txt");
        List<String> subjects = new ArrayList<>();

        System.out.println(" Reading student file: " + file.getAbsolutePath());

        if (!file.exists()) {
            System.out.println(" Student file not found.");
            return subjects;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Subjects:")) {
                    String[] split = line.substring(9).split(",");
                    for (String s : split) {
                        subjects.add(s.trim());
                    }
                    break;
                }
            }
        }

        System.out.println(" Loaded subjects for student " + studentId + ": " + subjects);
        return subjects;
    }

    public List<ExamEntry> getAvailableExams(String studentId, List<String> subjects) {
        File folder = new File(basePath + "/Exams");
        File[] examFiles = folder.listFiles();
        List<ExamEntry> list = new ArrayList<>();

        System.out.println(" Checking exams in folder: " + folder.getAbsolutePath());

        if (examFiles != null) {
            for (File file : examFiles) {
                String fileName = file.getName();
                System.out.println(" Found exam file: " + fileName);

                String name = fileName.replace(".txt", "");
                String[] parts = name.split("_");

                if (parts.length == 3) {
                    String subject = parts[0];
                    String datePart = parts[1];
                    String timePart = parts[2];

                    if (subjects.contains(subject)) {
                        File submissionMarker = new File(basePath + "/Submissions/" + studentId + "_" + fileName);
                        System.out.println("🔎 Checking submission marker: " + submissionMarker.getAbsolutePath());

                        if (!submissionMarker.exists()) {
                            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                                String lecturerLine = reader.readLine();
                                String durationLine = reader.readLine();
                                String questionCountLine = reader.readLine();

                                String lecturer = (lecturerLine != null && lecturerLine.startsWith("Lecturer:"))
                                        ? lecturerLine.substring(9).trim()
                                        : "Unknown";

                                int questionCount = (questionCountLine != null && questionCountLine.startsWith("QuestionCount:"))
                                        ? Integer.parseInt(questionCountLine.substring(14).trim())
                                        : 0;

                                LocalDate date = LocalDate.parse(datePart);
                                LocalTime time = LocalTime.parse(timePart.replace("-", ":"));

                                ExamEntry entry = new ExamEntry(subject, lecturer, questionCount, date, time, fileName);
                                list.add(entry);

                                System.out.println(" Exam added: " + entry);
                            } catch (Exception e) {
                                System.out.println("️ Failed to parse exam file: " + fileName);
                                e.printStackTrace();
                            }
                        } else {
                            System.out.println(" Already submitted: " + fileName);
                        }
                    } else {
                        System.out.println(" Subject does not match for student: " + subject);
                    }
                } else {
                    System.out.println(" Filename format invalid: " + fileName);
                }
            }
        } else {
            System.out.println(" No exam files found.");
        }

        list.sort(Comparator.comparing(ExamEntry::getDate).thenComparing(ExamEntry::getTime));
        System.out.println(" Final exam list: " + list.size() + " exams");
        return list;
    }
}
