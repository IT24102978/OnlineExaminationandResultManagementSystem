package student;

@WebServlet("/delete")
public class DeleteStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String id = req.getParameter("id");

        File inputFile = new File("C:/exam-system/students.txt");
        File tempFile = new File("C:/exam-system/students_tmp.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));

        String line;
        boolean deleted = false;
        while ((line = reader.readLine()) != null) {
            if (!line.startsWith(id + ",")) {
                writer.write(line);
                writer.newLine();
            } else {
                deleted = true;
            }
        }

        writer.close();
        reader.close();

        inputFile.delete();
        tempFile.renameTo(inputFile);

        res.setContentType("text/html");
        res.getWriter().println(deleted ? "Student deleted." : "Student not found.");
    }
}
