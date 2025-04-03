package student;

@WebServlet("/read")
public class ReadStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String id = req.getParameter("id");
        BufferedReader reader = new BufferedReader(new FileReader("C:/exam-system/students.txt"));
        String line;
        boolean found = false;

        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        while ((line = reader.readLine()) != null) {
            if (line.startsWith(id + ",")) {
                out.println("<pre>" + line + "</pre>");
                found = true;
                break;
            }
        }

        if (!found) {
            out.println("Student not found.");
        }

        reader.close();
    }
}
