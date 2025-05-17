<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.result.leaderboard.StudentResult" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leaderboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-pink-100 via-purple-100 to-blue-100 min-h-screen p-10 font-sans">
<div class="container mx-auto">
    <h1 class="text-5xl font-extrabold mb-12 text-center text-purple-700 drop-shadow-md">🏆 Subject-wise Leaderboard</h1>

    <%
        List<StudentResult> allResults = (List<StudentResult>) request.getAttribute("allResults");
        Set<String> displayedSubjects = new HashSet<>();

        if (allResults != null) {
            for (StudentResult sr : allResults) {
                if (!displayedSubjects.contains(sr.subject)) {
                    displayedSubjects.add(sr.subject);
    %>
    <div class="glass rounded-3xl p-8 mb-12 border border-purple-100">
        <h2 class="text-3xl font-bold text-purple-800 mb-6 border-b-2 border-purple-200 pb-2">
            <%= sr.subject %>
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <%
                int count = 0;
                for (StudentResult sr2 : allResults) {
                    if (sr2.subject.equals(sr.subject) && count < 3) {
                        String trophy = "", bgColor = "";
                        switch (count) {
                            case 0: trophy = "🥇"; bgColor = "bg-gradient-to-r from-amber-400 to-amber-200"; break;
                            case 1: trophy = "🥈"; bgColor = "bg-gradient-to-r from-gray-300 to-gray-100"; break;
                            case 2: trophy = "🥉"; bgColor = "bg-gradient-to-r from-amber-500 to-amber-300"; break;
                        }
            %>
            <div class="<%= bgColor %> rounded-xl p-6 shadow-lg">
                <div class="text-center">
                    <div class="text-5xl mb-3 animate-bounce"><%= trophy %></div>
                    <h3 class="text-xl font-bold text-gray-900"><%= sr2.name %></h3>
                    <p class="text-gray-700 mt-2 text-lg font-semibold">Marks: <%= sr2.Marks %></p>
                    <p class="text-sm text-gray-600 mt-1">Rank <%= count + 1 %></p>
                </div>
            </div>
            <%
                        count++;
                    }
                }
            %>
        </div>
    </div>
    <%
            }
        }
    } else {
    %>
    <p class="text-center text-red-600 text-xl mt-10">Leaderboard data is not available.</p>
    <% } %>

    <a href="result" class="bg-red-500 text-white hover:bg-red-600 px-6 py-2 rounded-lg shadow-md transition-all duration-200">Back</a>

</div>
</body>
</html>
