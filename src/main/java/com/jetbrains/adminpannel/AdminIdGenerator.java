package com.jetbrains.adminpannel;

import java.io.*;
import java.util.regex.*;

public class AdminIdGenerator {
    public static String getNextAdminId(String filePath) {
        String lastId = "A000";
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            Pattern pattern = Pattern.compile("^(A\\d+)");
            while ((line = reader.readLine()) != null) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.find()) {
                    String currentId = matcher.group(1);
                    if (currentId.compareTo(lastId) > 0) {
                        lastId = currentId;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        int nextNumber = Integer.parseInt(lastId.substring(1)) + 1;
        return String.format("A%03d", nextNumber);
    }
}