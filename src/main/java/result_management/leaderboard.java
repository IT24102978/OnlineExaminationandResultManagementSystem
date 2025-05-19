package result_management;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import result_management.controllers.*;

@WebServlet("/leaderboard")
public class leaderboard extends HttpServlet {

    public static class StudentResult {
        public String name;
        public String subjectCode;
        public String subject;
        public int Marks;

        public StudentResult(String name, String subjectCode, String subject, int Marks) {
            this.name = name;
            this.subjectCode = subjectCode;
            this.subject = subject;
            this.Marks = Marks;
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = request.getServletContext().getRealPath("data/results.txt");
        List<StudentResult> allResults = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2) {
                    String name = data[0].trim();
                    String subjectCode = data[1].trim();
                    String subject = data[2].trim();
                    int Marks;
                    try {
                        Marks = Integer.parseInt(data[3].trim());
                    } catch (NumberFormatException e) {
                        Marks = 0;
                    }
                    StudentResult result = new StudentResult(name, subjectCode, subject, Marks);
                    allResults.add(result);
                }
            }
        }

        

        SelectionSorter.sortByScoreDescending(allResults);

        request.setAttribute("allResults", allResults);
        request.getRequestDispatcher("/leaderboard.jsp").forward(request, response);
    }
}
