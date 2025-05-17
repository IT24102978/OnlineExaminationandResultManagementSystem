//manages student records using a LinkedList
// loads & stores records in students.txt
// CRUD operations: Create, Read, Update, Delete

package com.example.demo;

import java.io.*;
import java.util.*;

public class StudentManager {
    private LinkedList<Student> students;

// Constructor
    public StudentManager() {
        students = new LinkedList<>();
        loadFromFile();
    }

    // Create: Add a new student
    public void addStudent(Student student) {
        students.add(student);
        saveToFile();
    }

    // Read: Search student by ID
    public Student searchStudentById(String id) {
        for (Student student : students) {
            if (student.getId().equals(id)) {
                return student;
            }
        }
        return null;
    }

    // Read: Search student by name
    public Student searchStudentByName(String name) {
        for (Student student : students) {
            if (student.getFullName().equalsIgnoreCase(name)) {
                return student;
            }
        }
        return null;
    }

    // Update: Update student details
    public boolean updateStudent(String id, String firstName, String lastName, String email, String course) {
        Student student = searchStudentById(id);
        if (student != null) {
            student.setFirstName(firstName);
            student.setLastName(lastName);
            student.setEmail(email);
            student.setCourse(course);
            saveToFile();
            return true;
        }
        return false;
    }

    // Delete: Delete student by ID
    public boolean deleteStudentById(String id) {
        Student student = searchStudentById(id);
        if (student != null) {
            students.remove(student);
            saveToFile();
            return true;
        }
        return false;
    }

    // Read: List all students (Admin View)
    public LinkedList<Student> getAllStudents() {
        return students;
    }

    // Load students from the file
    private void loadFromFile() {
        try (BufferedReader br = new BufferedReader(new FileReader("students.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 6) { // Expecting 6 fields: id, firstName, lastName, email, course, password
                    String id = data[0];
                    String firstName = data[1];
                    String lastName = data[2];
                    String email = data[3];
                    String course = data[4];
                    String password = data[5];
                    Student student = new Student(id, firstName, lastName, email, course, password);
                    students.add(student);
                } else {
                    System.out.println("Invalid data format: " + line);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading from file: " + e.getMessage());
        }
    }

    // Save students to the file
    private void saveToFile() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter("students.txt"))) {
            for (Student student : students) {
                bw.write(student.getId() + "," + student.getFirstName() + "," + student.getLastName() + "," +
                        student.getEmail() + "," + student.getCourse() + "," + student.getPassword());
                bw.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }
}