package sign_in_and_exam_management;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class StudentController extends HttpServlet {
    private StudentManager studentManager;

    @Override
    public void init() {
        studentManager = (StudentManager) getServletContext().getAttribute("studentManager");
        if (studentManager == null) {
            studentManager = new StudentManager(getServletContext());
            getServletContext().setAttribute("studentManager", studentManager);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Signup to create new student
        if ("signup".equals(action)) {
            String id = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String course = request.getParameter("course");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                response.sendRedirect("signup2.jsp?error=Passwords do not match");
                return;
            }

            if (studentManager.searchStudentById(id) != null) {
                response.sendRedirect("signup2.jsp?error=Student ID already exists");
                return;
            }

            if (id != null && firstName != null && lastName != null && email != null && course != null && password != null) {
                Student student = new Student(id, firstName, lastName, email, course, password);
                studentManager.addStudent(student);
                response.sendRedirect("studentLogin.jsp");
            } else {
                response.sendRedirect("signup2.jsp?error=Invalid input");
            }

            // Student login
        } else if ("login".equals(action)) {
            String id = request.getParameter("id");
            String password = request.getParameter("password");

            Student student = studentManager.searchStudentById(id);
            if (student != null && student.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("student", student);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("studentLogin.jsp?error=Invalid ID or password");
            }

            // Update student info
        } else if ("update".equals(action)) {
            String id = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String course = request.getParameter("course");

            if (id != null && firstName != null && lastName != null && email != null && course != null) {
                boolean updated = studentManager.updateStudent(id, firstName, lastName, email, course);
                if (updated) {
                    response.sendRedirect("StudentController?action=getStudents");
                } else {
                    response.sendRedirect("editStudent.jsp?id=" + id + "&error=Update failed");
                }
            } else {
                response.sendRedirect("editStudent.jsp?id=" + id + "&error=Invalid input");
            }

            // Delete student
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                boolean deleted = studentManager.deleteStudentById(id);
                if (deleted) {
                    response.sendRedirect("StudentController?action=getStudents");
                } else {
                    response.sendRedirect("students.jsp?error=Delete failed");
                }
            } else {
                response.sendRedirect("students.jsp?error=Invalid ID");
            }
        }
    }

    // Handling GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        HttpSession session = request.getSession();

        if ("getStudents".equals(action)) {
            Node current = studentManager.getAllStudents();
            List<Student> students = new java.util.ArrayList<>();

            while (current != null) {
                students.add(current.data);
                current = current.next;
            }
            session.setAttribute("students", students);

            // Forward to students.jsp for editing
            response.sendRedirect("students.jsp");

        } else if ("edit".equals(action)) {
            if (id != null) {
                Student student = studentManager.searchStudentById(id);
                request.setAttribute("student", student);

                //Forward to editStudent.jsp for editing
                RequestDispatcher dispatcher = request.getRequestDispatcher("editStudent.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("students.jsp?error=Invalid ID");
            }
        }
    }
}
