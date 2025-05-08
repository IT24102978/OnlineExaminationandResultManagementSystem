<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Exam Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f4f4;
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
            padding-top: 60px;
        }
        .dashboard-cards .card {
            text-align: center;
            color: white;
            padding: 20px;
            border-radius: 8px;
            transition: transform 0.3s;
            position: relative;
        }
        .dashboard-cards .card:hover {
            transform: scale(1.05);
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
            text-decoration: none;   /* removes underline */
            font-weight: bold;       /* makes text bold */
            color: white;          /* dark gray-blue instead of blue */
            font-family: 'Poppins', sans-serif; /* optional: modern font */
        }

        a:hover {
            color: #3498db; /* change color on hover (optional) */
        }
    </style>
</head>
<body>

<% if (session.getAttribute("student") == null) {
    response.sendRedirect("login.jsp");
    return;
} %>

<div class="top-bar">
    <button class="menu-btn">&#9776;</button>
    <div class="sidebar">
        <ul>
            <li><a href="dashboard.html">Dashboard</a></li>
            <li><a href="StudentController?action=getStudents">Students</a></li>
            <li><a href="#">Exams</a></li>
            <li><a href="#">Result</a></li>
            <li><a href="#">Feedbacks</a></li>
            <li><a href="#">Lecturers</a></li>
            <li><a href="#">System Users</a></li>
        </ul>
    </div>
</div>
<div class="container mt-4" id="main-content"><br>
    <h2 class="text-center">Dashboard</h2>
    <br>
    <div class="row dashboard-cards mt-4">
        <div class="col-md-4">
            <div class="card bg-warning">
                <h3>1</h3>
                <p>Department</p>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-danger">
                <h3>2</h3>
                <p>Course</p>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success">
                <h3>3</h3>
                <p>Class</p>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-primary">
                <h3>4</h3>
                <p>Admin</p>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info">
                <h3>5</h3>
                <p>Students</p>
                <div class="card-footer">
                    <span>More info</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-dark">
                <h3>6</h3>
                <p>System Users</p>
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