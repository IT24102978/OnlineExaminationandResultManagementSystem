package controllers;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class resultController {
    public void writeResult(String FILE_PATH, String data) {
        try (
                FileWriter fw = new FileWriter(FILE_PATH, true)) {
            fw.write(data);
        } catch (IOException e) {
            e.printStackTrace();

        }
    }

    public List<String[]> readResultsFromFile(String FILE_PATH) throws IOException {
        List<String[]> results = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                results.add(line.split(","));
            }
        }
        return results;
    }

    public boolean updateResult(String resultFilePath,String studentId, String subjectCode, String studentName,
                                String subject, String credits, String attempt, String grade) {

        List<String> updatedResults = new ArrayList<>();
        boolean recordUpdated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(resultFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 7 && data[0].equals(studentId) && data[1].equals(subjectCode)) {
                    // Rebuild the updated line
                    line = studentName + "," + subjectCode + "," + subject + "," + credits + "," + "," + attempt + "," + grade;
                    recordUpdated = true;
                }
                updatedResults.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (recordUpdated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(resultFilePath))) {
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
