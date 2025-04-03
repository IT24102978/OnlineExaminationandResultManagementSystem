package student;

public class Student {
    protected String id, name, email, course;

    public Student(String id, String name, String email, String course) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.course = course;
    }

    public String toCSV() {
        return id + "," + name + "," + email + "," + course;
    }

    // Getters and setters...
}
