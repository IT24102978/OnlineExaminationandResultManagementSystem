<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Exam Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            padding-top: 50px;
            overflow-x: hidden;
            font-family: 'Poppins', sans-serif;
            background: url('images/wallpaper.jpg') no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(5px);
        }
        .title-heading {
            font-family: Georgia, serif;
        }

        .top-bar {
            width: 100%;
            height: 50px;
            background: black;
            display: flex;
            align-items: center;
            padding-left: 20px;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        .menu-btn {
            font-size: 24px;
            background: transparent;
            border: none;
            color: white;
            padding: 10px;
            cursor: pointer;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #333;
            position: fixed;
            top: 0;
            left: -250px;
            transition: left 0.3s ease-in-out;
            padding-top: 60px;
            color: white;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px;
            cursor: pointer;
            border-bottom: 1px solid #444;
        }
        .sidebar ul li:hover {
            background: #555;
        }
        .menu-btn:hover + .sidebar, .sidebar:hover {
            left: 0;
        }
        .container {
            width: 100%;
            margin: 0 auto;
            padding-top: 60px;
        }
        .dashboard-cards .card {
            text-align: center;
            color: white;
            padding: 20px;
            border-radius: 8px;
            transition: transform 0.3s;
            position: relative;
            margin-bottom: 25px;
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
            font-family: 'Poppins', sans-serif;
        }

        a:hover {
            color: #3498db;
        }

        h1 {
            margin-top: 0;
        }
    </style>
</head>
<body>

<% if (session.getAttribute("student") == null) {
    response.sendRedirect("studentLogin.jsp");
    return;
} %>

<div class="top-bar">
    <button class="menu-btn">☰</button>
    <div class="sidebar">
        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="StudentController?action=getStudents">Students</a></li>
            <li><a href="#">Exams</a></li>
            <li><a href="#">Result</a></li>
            <li><a href="#">Feedbacks</a></li>
            <li><a href="index.jsp"><font color=" red">Log out</font></a></li>
        </ul>
    </div>
</div>
<div class="container mt-4" id="main-content"><br>
    <h1 class="text-center title-heading"><b>Student    Dashboard</b></h1>

    <br>
    <div class="row dashboard-cards mt-4">
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>1</h3>
                <h4>Subjects</h4><br>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>2</h3>
                <h4>Exams</h4><br>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>3</h3>
                <h4>Results</h4><br>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>4</h3>
                <h4>Feedbacks</h4><br>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>