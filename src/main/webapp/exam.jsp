<%@ page import="java.util.*, sign_in_and_exam_management.MCQ" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ArrayList<MCQ> mcqList = (ArrayList<MCQ>) session.getAttribute("mcqList");
    if (mcqList == null) mcqList = new ArrayList<>();

    int duration = (session.getAttribute("examDuration") != null)
            ? (int) session.getAttribute("examDuration")
            : 60; // default fallback

    sign_in_and_exam_management.Student student = (sign_in_and_exam_management.Student) session.getAttribute("student");
    String userFirstName = student != null ? student.getFirstName() : "User";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Take Exam</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        html, body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            padding-top: 50px;
            overflow-x: hidden;
            background: url("images/wallpaper.jpg") no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(5px);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ✅ Top Bar */
        .top-bar {
            width: 100%;
            height: 70px;
            background: black;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            color: white;
            font-weight: 600;
            user-select: none;
        }

        .menu-btn {
            font-size: 24px;
            background: transparent;
            border: none;
            color: white;
            padding: 10px;
            cursor: pointer;
        }

        .welcome-msg {
            font-size: 1.2rem;
            margin-top: 10px;
            padding-left: 10px;
        }

        /* ✅ Sidebar */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #333;
            position: fixed;
            top: 70px;
            left: -250px;
            transition: left 0.3s ease-in-out;
            padding-top: 20px;
            color: white;
            z-index: 999;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar ul li {
            padding: 15px;
            cursor: pointer;
            border-bottom: 1px solid #444;
        }

        .sidebar ul li:hover {
            background: #555;
        }

        .sidebar ul li a {
            text-decoration: none;
            font-weight: bold;
            color: white;
            font-family: "Poppins", sans-serif;
        }

        .sidebar ul li a:hover {
            color: #3498db;
        }

        .footer {
            height: 40px;
            background-color: #3b4a68;
            color: white;
            text-align: center;
            line-height: 40px;
            font-size: 14px;
            font-family: "Poppins", sans-serif;
            margin-top: auto;
        }

        .main-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .timer {
            font-size: 22px;
            font-weight: bold;
            color: #fff;
            margin-bottom: 20px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 20px rgba(100, 0, 200, 0.08);
        }

        h2 {
            color: #3b4a68;
            text-align: center;
            margin-bottom: 30px;
        }

        .question-and-map {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 40px;
            margin-top: 30px;
        }

        .left-question {
            flex: 2;
            min-width: 500px;
        }

        .right-map {
            flex: 1;
            min-width: 200px;
        }

        .section-title {
            font-weight: bold;
            text-align: center;
            margin-bottom: 10px;
            color: #333;
        }

        .question-container {
            display: none;
            padding: 20px;
            background-color: #faf8ff;
            border: 1px solid #e0dff5;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .question-container.active {
            display: block;
        }

        .question-container p {
            font-weight: bold;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin: 8px 0;
            font-size: 15px;
        }

        .navigation-buttons,
        .submit-section {
            text-align: center;
            margin-top: 30px;
        }

        .navigation-buttons button,
        .submit-section input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            margin: 0 8px;
            transition: background 0.2s ease-in-out;
        }

        .navigation-buttons button:hover,
        .submit-section input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .question-map {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            justify-content: center;
            background-color: #f0effb;
            padding: 20px;
            border-radius: 16px;
        }

        .question-box {
            width: 50px;
            height: 50px;
            background-color: #ccc;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .question-box:hover {
            background-color: #a3a3a3;
        }

        .question-box.current {
            border: 2px solid #3b4a68;
        }

        .question-box.answered {
            background-color: #4caf50;
            color: white;
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

<!-- ✅ Top Bar -->
<div class="top-bar">
    <button class="menu-btn" id="menuBtn">☰</button>
    <div class="welcome-msg">Welcome,&nbsp;<%= userFirstName %> !</div>
</div>

<!-- ✅ Sidebar -->
<div class="sidebar" id="sidebar">
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="StudentController?action=getStudents">Students</a></li>
        <li><a href="<%= request.getContextPath() %>/showExams?studentId=<%= student.getId() %>">Exams</a></li>
        <li><a href="#">Result</a></li>
        <li><a href="#">Feedbacks</a></li>
        <li><a href="showexam.jsp" style="color: red;">Log out</a></li>
    </ul>
</div>

<!-- ✅ Main Content -->
<div class="main-wrapper">
    <div class="timer">
        Time Remaining: <span id="timer">--:--</span>
    </div>

    <div class="container">
        <h2><i data-lucide="book-open"></i> Take Your Exam</h2>

        <form action="SubmitExamServlet" method="post" id="examForm" onsubmit="return confirmSubmission();">
            <div class="question-and-map">
                <div class="left-question">
                    <div class="section-title">Question</div>
                    <div id="questions">
                        <% for (int i = 0; i < mcqList.size(); i++) {
                            MCQ mcq = mcqList.get(i);
                        %>
                        <div class="question-container <%= (i == 0) ? "active" : "" %>" id="question-<%= i %>">
                            <p>Q<%= i + 1 %>: <%= mcq.getQuestion() %></p>
                            <label><input type="radio" name="q<%= i %>" value="A" required> <%= mcq.getOptionA() %></label>
                            <label><input type="radio" name="q<%= i %>" value="B"> <%= mcq.getOptionB() %></label>
                            <label><input type="radio" name="q<%= i %>" value="C"> <%= mcq.getOptionC() %></label>
                            <label><input type="radio" name="q<%= i %>" value="D"> <%= mcq.getOptionD() %></label>
                        </div>
                        <% } %>
                    </div>

                    <div class="navigation-buttons">
                        <button type="button" onclick="prevQuestion()"><i data-lucide="arrow-left"></i> Previous</button>
                        <button type="button" onclick="nextQuestion()">Next <i data-lucide="arrow-right"></i></button>
                    </div>

                    <div class="submit-section">
                        <input type="submit" value="Submit Exam">
                    </div>
                </div>

                <div class="right-map">
                    <div class="section-title">Question navigation</div>
                    <div class="question-map">
                        <% for (int i = 0; i < mcqList.size(); i++) { %>
                        <div class="question-box" id="qbox-<%= i %>" onclick="goToQuestion(<%= i %>)"><%= i + 1 %></div>
                        <% } %>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- ✅ Footer -->
<div class="footer">
    &copy; project_group_198 &nbsp; All rights reserved
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();

    document.getElementById("menuBtn").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    });

    let currentQuestion = 0;
    const totalQuestions = <%= mcqList.size() %>;
    const examDurationMinutes = <%= duration %>;
    let timeLeft = examDurationMinutes * 60;

    function showQuestion(index) {
        const all = document.querySelectorAll(".question-container");
        all.forEach(q => q.classList.remove("active"));
        if (index >= 0 && index < all.length) {
            all[index].classList.add("active");
            currentQuestion = index;
        }

        document.querySelectorAll(".question-box").forEach(box => box.classList.remove("current"));
        const box = document.getElementById("qbox-" + index);
        if (box) box.classList.add("current");

        updateQuestionBoxes();
    }

    function nextQuestion() {
        if (currentQuestion < totalQuestions - 1) showQuestion(++currentQuestion);
    }

    function prevQuestion() {
        if (currentQuestion > 0) showQuestion(--currentQuestion);
    }

    function goToQuestion(index) {
        showQuestion(index);
    }

    function updateQuestionBoxes() {
        const allRadios = document.querySelectorAll("input[type=radio]");
        const answered = new Set();

        allRadios.forEach(input => {
            if (input.checked) {
                const index = input.name.replace("q", "");
                const box = document.getElementById("qbox-" + index);
                if (box) {
                    box.classList.add("answered");
                    answered.add(index);
                }
            }
        });

        for (let i = 0; i < totalQuestions; i++) {
            if (!answered.has(i.toString())) {
                const box = document.getElementById("qbox-" + i);
                if (box) box.classList.remove("answered");
            }
        }
    }

    function startTimer() {
        const timerDisplay = document.getElementById("timer");
        const countdown = setInterval(() => {
            const min = Math.floor(timeLeft / 60);
            const sec = timeLeft % 60;
            timerDisplay.textContent = String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
            if (timeLeft <= 0) {
                clearInterval(countdown);
                document.getElementById("examForm").submit();
            }
            timeLeft--;
        }, 1000);
    }

    function confirmSubmission() {
        return confirm("Are you sure you want to submit and get your score? You won’t be able to change your answers after this.");
    }

    window.addEventListener("DOMContentLoaded", () => {
        showQuestion(currentQuestion);
        updateQuestionBoxes();
        startTimer();

        document.querySelectorAll("input[type=radio]").forEach(input => {
            input.addEventListener("change", updateQuestionBoxes);
        });
    });
</script>

</body>
</html>
