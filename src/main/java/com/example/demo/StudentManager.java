package com.example.demo;

import java.io.*;

public class StudentManager {
    private MyLinkedList students;

    // Constructor
    public StudentManager() {
        students = new MyLinkedList();
        loadFromFile();
    }

    // Create: Add a new student
    public void addStudent(Student student) {
        students.add(student);
        saveToFile();
    }

    // Read: Search student by ID
    public Student searchStudentById(String id) {
        return students.searchById(id);
    }

    // Read: Search student by name
    public Student searchStudentByName(String name) {
        Node current = students.getHead();
        while (current != null) {
            if (current.data.getFullName().equalsIgnoreCase(name)) {
                return current.data;
            }
            current = current.next;
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
        boolean deleted = students.deleteById(id);
        if (deleted) {
            saveToFile();
            return true;
        }
        return false;
    }

    // Read: Return the head node
    public Node getAllStudents() {
        return students.getHead();
    }

    // Load students from students.txt
    private void loadFromFile() {
        try (BufferedReader br = new BufferedReader(new FileReader("students.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 6) {
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

    // Save students to students.txt
    private void saveToFile() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter("students.txt"))) {
            Node current = students.getHead();
            while (current != null) {
                Student s = current.data;
                bw.write(s.getId() + "," + s.getFirstName() + "," + s.getLastName() + "," +
                        s.getEmail() + "," + s.getCourse() + "," + s.getPassword());
                bw.newLine();
                current = current.next;
            }
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }
}
