package com.example.demo;

public class Student {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String course;
    private String password;

    public Student(String id, String firstName, String lastName, String email, String course, String password) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.course = course;
        this.password = password;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if(email != null && email.contains("@")) {
            this.email = email;
        } else {
            this.email = "invalid@email.com";
            System.out.println("Invalid email address");
        }
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    @Override
    public String toString() {
        return id + "," + getFullName() + "," + email + "," + course + "," + password;
    }
}