package result_management;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import result_management.controllers.resultController;
import result_management.controllers.studentController;
import result_management.controllers.subjectController;

import java.io.IOException;
import java.util.List;

@WebServlet("/submitResultServlet")
public class submitResultServlet extends HttpServlet {

//    private static final String FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";
//    private static final String STUDENT_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/students.txt";
//    private static final String SUB_FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/subjects.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        String FILE_PATH = "E:/java/msDulmi/src/main/webapp/data/results.txt";
        String FILE_PATH = request.getServletContext().getRealPath("data/results.txt");
        String STUDENT_FILE_PATH = request.getServletContext().getRealPath("data/students.txt");
        String SUB_FILE_PATH = request.getServletContext().getRealPath("data/subjects.txt");


        // Get form data
        String studentId = request.getParameter("studentID");
        String subjectCode = request.getParameter("subjectCode");
        String Marks = request.getParameter("Marks");
        String grade = request.getParameter("grade");

        // Get the student name using the ID

        studentController scontroller = new studentController();
        resultController rsController = new resultController(FILE_PATH);
        subjectController scController = new subjectController();

        List<String[]> students = scontroller.readStudents(STUDENT_FILE_PATH);
        String studentName = scontroller.getStudentNameById(students, studentId);

        List<String[]> sub = scController.readSub(SUB_FILE_PATH);
        String subName = scController.subNameById(sub, subjectCode);


        // Handle if student name is not found
        if (studentName == null) {
            response.getWriter().println("<p>Student not found!</p>");
            return;
        }

        // Prepare data to be written to the results file
        String data = studentName + ","  + subjectCode + "," + subName + "," + Marks + "," + grade + "\n";
        rsController.writeResult(data);


        // Redirect to the results page
        response.sendRedirect("result");
    }

    // Method to read students from the file







}
