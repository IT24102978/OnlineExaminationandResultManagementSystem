package com.jetbrains.adminpannel;

import jakarta.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class UserStats {

    public static int countStudents(ServletContext context) {
        int count = 0;

        try {
            InputStream input = context.getResourceAsStream("/WEB-INF/users.txt");
            if (input != null) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(input));
                String line;
                while ((line = reader.readLine()) != null) {
                    line = line.trim();
                    if (line.startsWith("S")) {
                        count++;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return count;
    }
}
