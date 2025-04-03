package student;

@WebServlet("/update")
public class UpdateStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String course = req.getParameter("course");

        File inputFile = new File("C:/exam-system/students.txt");
        File tempFile = new File("C:/exam-system/students_tmp.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));

        String line;
        boolean updated = false;
        while ((line = reader.readLine()) != null) {
            if (line.startsWith(id + ",")) {
                String[] parts = line.split(",");
                String type = parts[4]; // keep the same type
                writer.write(id + "," + name + "," + email + "," + course + "," + type);
                updated = true;
            } else {
                writer.write(line);
            }
            writer.newLine();
        }

        writer.close();
        reader.close();

        inputFile.delete();
        tempFile.renameTo(inputFile);

        res.setContentType("text/html");
        res.getWriter().println(updated ? "Student updated." : "Student not found.");
    }
}
