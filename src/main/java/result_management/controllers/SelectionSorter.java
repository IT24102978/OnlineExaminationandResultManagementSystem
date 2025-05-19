package result_management.controllers;

import result_management.leaderboard;

import java.util.List;

public class SelectionSorter {
    public static void sortByScoreDescending(List<leaderboard.StudentResult> results) {
        for (int i = 0; i < results.size() - 1; i++) {
            int maxIndex = i;
            for (int j = i + 1; j < results.size(); j++) {
                if (results.get(j).Marks > results.get(maxIndex).Marks) {
                    maxIndex = j;
                }
            }
            // Swap the found maximum element with the first element
            leaderboard.StudentResult temp = results.get(maxIndex);
            results.set(maxIndex, results.get(i));
            results.set(i, temp);
        }
    }
}
