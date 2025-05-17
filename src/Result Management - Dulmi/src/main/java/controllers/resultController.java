package controllers;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class resultController {

    private String FILE_PATH;
    private List<String[]> results = new ArrayList<>();

    public resultController(String filePath) {
        this.FILE_PATH = filePath;
    }


    public void writeResult(String data) {
        try (
                FileWriter fw = new FileWriter(this.FILE_PATH, true)) {
            fw.write(data);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<String[]> readResultsFromFile() throws IOException {
//        List<String[]> results = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(this.FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                this.results.add(line.split(","));
            }
        }
        return results;
    }

    public boolean updateResult(String subjectCode, String studentName,
                                String subject, String Marks, String grade) {

        List<String> updatedResults = new ArrayList<>();
        boolean recordUpdated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(this.FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data[0].equals(studentName) && data[1].equals(subjectCode)) {
                    // Rebuild the updated line
                    line = studentName + "," + subjectCode + "," + subject + "," + Marks + "," + grade;
                    recordUpdated = true;
                }
                updatedResults.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (recordUpdated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(this.FILE_PATH))) {
                for (String updatedLine : updatedResults) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return recordUpdated;
    }

}
