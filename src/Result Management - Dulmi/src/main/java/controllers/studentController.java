package controllers;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class studentController {
    public List<String[]> readStudents(String STUDENT_FILE_PATH) {
        List<String[]> students = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(STUDENT_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] student = line.split(",");
                if (student.length >= 2) {
                    students.add(student); // [0] = ID, [1] = Name
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Method to get the student name by student ID
    public String getStudentNameById(List<String[]> students, String studentId) {
        for (String[] student : students) {
            if (student[0].equals(studentId)) { // student[0] is ID
                return student[1] + " " + student[2]; // student[1] is Name
            }
        }
        return null; // Return null if student ID not found
    }



}
