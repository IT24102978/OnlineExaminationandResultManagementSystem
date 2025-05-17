<%@ page import="java.util.*" %>
<%@ page import="com.example.oop_project.MCQ" %>

<%
    ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Exam Submitted</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f6ff;
            color: #333;
        }

        .header {
            background-color: #5c3d99;
            color: white;
            padding: 15px 40px;
            font-size: 20px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .footer {
            background-color: #5c3d99;
            color: white;
            text-align: center;
            padding: 12px;
            font-size: 14px;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        .container {
            max-width: 800px;
            margin: 80px auto 60px;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 20px rgba(100, 0, 200, 0.08);
        }

        h2 {
            color: #5c3d99;
            margin-bottom: 10px;
        }

        h3 {
            color: #444;
            margin-bottom: 20px;
        }

        .question-block {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .question {
            font-weight: bold;
            color: #3f3f3f;
            margin-bottom: 8px;
        }

        .answer {
            color: #5c3d99;
        }

        .next-btn {
            display: inline-block;
            background-color: #5c3d99;
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
            transition: background 0.2s ease-in-out;
            margin-top: 20px;
        }

        .next-btn:hover {
            background-color: #472f74;
        }

        [data-lucide] {
            width: 16px;
            height: 16px;
            vertical-align: middle;
            margin-right: 6px;
        }
    </style>
</head>
<body>

<!-- ✅ HEADER -->
<div class="header">
    Online Exam System &nbsp;
</div>

<div class="container">
    <h2><i data-lucide="check-circle"></i> Exam Submitted Successfully!</h2>
    <h3>Your Answers:</h3>

    <% for (int i = 0; i < mcqList.size(); i++) {
        MCQ mcq = mcqList.get(i);
    %>
    <div class="question-block">
        <div class="question">Q<%= i + 1 %>: <%= mcq.getQuestion() %></div>
        <div class="answer">Your Answer: <%= mcq.getUserAnswer() %></div>
    </div>
    <% } %>

    <div style="text-align:center;">
        <a href="score.jsp" class="next-btn">
            <i data-lucide="arrow-right-circle"></i> View Your Marks
        </a>
    </div>
</div>

<!-- ✅ FOOTER -->
<div class="footer">
    &copy; project_group_198 &nbsp; All rights reserved
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
