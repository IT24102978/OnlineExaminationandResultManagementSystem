package result_management;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import result_management.controllers.resultController;

import java.io.IOException;
import java.util.List;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String FILE_PATH = request.getServletContext().getRealPath("data/results.txt");

        resultController rscontroller = new resultController(FILE_PATH);

        List<String[]> results = rscontroller.readResultsFromFile();

        request.setAttribute("results", results);
        request.getRequestDispatcher("results.jsp").forward(request, response);
    }
}
