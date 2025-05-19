<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Online Exam Dashboard</title>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    />
    <script
            src="https://kit.fontawesome.com/a076d05399.js"
            crossorigin="anonymous"
    ></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            height: 100%;
        }

        body {
            padding-top: 50px;
            overflow-x: hidden;
            font-family: "Poppins", sans-serif;
            background: url("images/wallpaper.jpg") no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(5px);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .title-heading {
            font-family: Georgia, serif;
        }

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

        .container {
            width: 100%;
            margin: 0 auto;
            padding-top: 90px;
            padding-left: 20px;
            padding-right: 20px;
            flex-grow: 1;
        }

        .dashboard-cards .card {
            text-align: center;
            color: white;
            padding: 20px;
            border-radius: 8px;
            transition: transform 0.3s;
            position: relative;
            margin-bottom: 25px;
            background-color: rgba(0, 0, 0, 0.7);
        }

        .dashboard-cards .card:hover {
            transform: scale(1.05);
        }

        .dashboard-cards .row {
            justify-content: center;
        }

        .card-footer {
            font-size: 16px;
            background: rgba(255, 255, 255, 0.2);
            color: rgba(255, 255, 255, 0.8);
            padding: 5px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            border-top: 1px solid rgba(255, 255, 255, 0.3);
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin: 8px 0;
        }

        a {
            text-decoration: none;
            font-weight: bold;
            color: white;
            font-family: "Poppins", sans-serif;
        }

        a:hover {
            color: #3498db;
        }

        h1 {
            margin-top: 0;
        }

        footer {
            height: 40px;
            background-color: black;
            color: white;
            text-align: center;
            line-height: 40px;
            font-size: 14px;
            font-family: "Poppins", sans-serif;
        }
    </style>
</head>
<body>

<%
    if (session.getAttribute("student") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    // Get the Student object from session
    sign_in_and_exam_management.Student student = (sign_in_and_exam_management.Student) session.getAttribute("student");

    String userFirstName = student != null ? student.getFirstName() : "User";
%>

<div class="top-bar">
    <button class="menu-btn" id="menuBtn">☰</button>
    <div class="welcome-msg">Welcome,&nbsp;<%= userFirstName %> !</div>
</div>

<div class="sidebar" id="sidebar">
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="StudentController?action=getStudents">Students</a></li>
        <li><a href="<%= request.getContextPath() %>/showExams?studentId=<%= student.getId() %>">Exams</a></li>
        <li><a href="leaderboard.jsp">Result</a></li>
        <li><a href="FeedbackIndex.jsp">Feedbacks</a></li>
        <li><a href="logout.jsp" style="color: red;">Log out</a></li>
    </ul>
</div>

<div class="container mt-4" id="main-content">
    <h1 class="text-center title-heading"><b>Student Dashboard</b></h1>

    <div class="row dashboard-cards mt-4">
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>1</h3>
                <h4>Exams</h4><br />
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>2</h3>
                <h4>Results</h4><br />
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>3</h3>
                <h4>Feedbacks</h4><br />
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    &copy; project_group_198 &nbsp; All rights reserved
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("menuBtn").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    });
</script>

</body>
</html>
