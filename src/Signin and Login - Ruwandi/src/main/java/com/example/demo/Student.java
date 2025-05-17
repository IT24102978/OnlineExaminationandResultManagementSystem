package com.example.demo;

public class Student {

    //used encapsulation
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

 // id getter & setter
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

// FirstName getter & setter
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

// LastName getter & setter
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

//  Email getter & setter
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
 // Course getter & setter
    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }

// Password getter & setter
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

 //  Full name method
    public String getFullName() {
        return firstName + " " + lastName;
    }

 // builds a single String with student details
    @Override
    public String toString() {
        return id + "," + getFullName() + "," + email + "," + course + "," + password;
    }
}