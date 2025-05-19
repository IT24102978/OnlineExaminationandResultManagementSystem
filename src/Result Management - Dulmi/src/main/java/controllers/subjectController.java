package controllers;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class subjectController {
    public List<String[]> readSub(String SUB_FILE_PATH) {
        List<String[]> subject = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(SUB_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] sub = line.split(",");
                if (sub.length >= 2) {
                    subject.add(sub); // [0] = ID, [1] = Name
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return subject;
    }

    public String subNameById(List<String[]> subjects, String SubCode) {
        for (String[] sub : subjects) {
            if (sub[0].equals(SubCode)) {
                return sub[1];
            }
        }
        
        return null;
    }
}
