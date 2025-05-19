<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp?error=Please+login+first");
        return;
    }
%>

<%@ page import="com.jetbrains.adminpannel.UserStats" %>
<%
    int studentCount = UserStats.countStudents(application);
%>


<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #1a1a2e;
            --accent: #d6d6d6;
            --success: #27ae60;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #ecf0f1;
            --dark: #121212;
            --card-bg: #2e2e2e;
            --sidebar-bg: #171717;
            --modal-bg: #3c3c3c;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--dark);
            color: var(--light);
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        /* Scrollbar styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #0a0a0a;
        }

        ::-webkit-scrollbar-thumb {
            background: #333;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--sidebar-bg) 0%, #16213e 100%);
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 100;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2.5rem;
        }

        .sidebar-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(90deg, #3498db, #2ecc71);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--light);
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 500;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .nav-link i {
            margin-right: 12px;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .server-status {
            background-color: rgba(0, 0, 0, 0.2);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 2rem;
        }

        .server-status p {
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #bbb;
        }

        .usage {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .progress-bar {
            height: 6px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
            flex-grow: 1;
        }

        .progress {
            height: 100%;
            width: 55%;
            background: linear-gradient(90deg, #3498db, #2ecc71);
            border-radius: 3px;
        }

        /* Main Content */
        .main {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            max-height: 100vh;
            overflow-y: auto;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-actions a {
            color: var(--light);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-actions a:hover {
            color: var(--accent);
        }

        .logout {
            background-color: rgba(231, 76, 60, 0.2);
            color: #e74c3c !important;
            padding: 0.5rem 1rem;
            border-radius: 6px;
        }

        .logout:hover {
            background-color: rgba(231, 76, 60, 0.3);
        }

        /* Search Bar */
        .search-container {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            width: 100%;
            max-width: 400px;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .search-container:focus-within {
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        .search-container i {
            color: #999;
            margin-right: 0.5rem;
        }

        .search-input {
            background: transparent;
            border: none;
            color: var(--light);
            font-size: 1rem;
            width: 100%;
            outline: none;
        }

        .search-input::placeholder {
            color: #777;
        }

        /* Cards */
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            width: 100%;
        }

        .card {
            background: linear-gradient(145deg, var(--card-bg), #535353);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 160px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, var(--accent), transparent);
        }

        .card p {
            font-size: 1rem;
            font-weight: 500;
            color: #bbb;
            margin-bottom: 0.5rem;
        }

        .card h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
        }

        .card-icon {
            position: absolute;
            bottom: 1rem;
            right: 1rem;
            font-size: 2.5rem;
            opacity: 0.1;
            color: var(--accent);
        }

        /* Action Buttons - IMPROVED STYLING */
        .action-buttons-container {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            width: 100%;
            margin: 1rem 0;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            width: 100%;
        }

        .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.25rem 1.75rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
        }

        .btn:hover::before {
            opacity: 1;
        }

        .btn i {
            font-size: 1.2rem;
        }

        .btn-green {
            background: linear-gradient(135deg, #219653, #27ae60);
            border-bottom: 4px solid #1e874b;
        }

        .btn-green:active {
            border-bottom-width: 2px;
            transform: translateY(2px);
        }

        .btn-red {
            background: linear-gradient(135deg, #c0392b, #e74c3c);
            border-bottom: 4px solid #a93226;
        }

        .btn-red:active {
            border-bottom-width: 2px;
            transform: translateY(2px);
        }

        .btn-brown {
            background: linear-gradient(135deg, #d35400, #e67e22);
            border-bottom: 4px solid #ba4a00;
        }

        .btn-brown:active {
            border-bottom-width: 2px;
            transform: translateY(2px);
        }

        /* Footer */
        footer {
            margin-top: auto;
            padding: 1.5rem 0;
            text-align: center;
            font-size: 0.9rem;
            color: #999;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 100vw;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal-overlay.active {
            opacity: 1;
        }

        .modal-box {
            background: linear-gradient(145deg, var(--modal-bg), #616161);
            padding: 2rem;
            border-radius: 16px;
            width: 500px;
            max-width: 95%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transform: translateY(20px);
            opacity: 0;
            transition: all 0.3s ease;
        }

        .modal-overlay.active .modal-box {
            transform: translateY(0);
            opacity: 1;
        }

        .modal-title {
            text-align: center;
            font-size: 1.5rem;
            color: white;
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .modal-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent), transparent);
            border-radius: 3px;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            color: #bbb;
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.8rem 1rem;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background-color: rgba(255, 255, 255, 0.05);
            color: white;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(218, 218, 218, 0.2);
        }

        .modal-note {
            font-size: 0.8rem;
            text-align: center;
            color: #bbb;
            margin: 1rem 0;
            padding: 0.5rem;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 6px;
            border-left: 3px solid var(--warning);
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .modal-buttons .btn {
            flex: 1;
            max-width: 150px;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div>
        <div class="sidebar-header">
            <h2>ADMIN CONTROLS</h2>
        </div>
        <nav class="nav-links">
            <a href="adminSignup.jsp" class="nav-link">
                <i class="fas fa-user-plus"></i>
                <span>Register Admin</span>
            </a>
            <a href="FeedbackServlet" class="nav-link">
                <i class="fas fa-file-alt"></i>
                <span>FeedBack</span>
            </a>
            <br>
            <br><br><br><br>
            <a href="https://dev.thecreativefactory.lk" class="nav-link">
                <i class="fas fa-link"></i>
                <span>Deployed Project Link</span>
            </a>
            <a href="teamMembers.jsp" class="nav-link">
                <i class="fas fa-users"></i>
                <span>Team Members</span>
            </a>
        </nav>
    </div>

    <div class="server-status">
        <p>SERVER STATUS</p>
        <div class="usage">
            <span>USAGE:</span>
            <div class="progress-bar">
                <div class="progress"></div>
            </div>
            <span style="color:#3498db;">55%</span>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main">
    <div class="top-bar">
        <h1 class="page-title">Admin Dashboard</h1>
        <div class="user-actions">
    <span style="color: #ccc; font-weight: 500;">
        <i class="fas fa-user-shield"></i> Logged in as : <%= session.getAttribute("adminUser") %>
    </span>
            <a href="logout.jsp" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <div class="search-container">
        <i class="fas fa-search"></i>
        <input type="text" class="search-input" placeholder="Search students, teachers, or courses...">
    </div>

    <div class="cards">
        <div class="card">
            <p>Total Students</p>
            <h1><%= studentCount %></h1>
            <i class="fas fa-user-graduate card-icon"></i>
        </div>

        <div class="card">
            <p>Subjects</p>
            <h1 class="counter" data-target="3">0</h1>
            <i class="fas fa-book card-icon"></i>
        </div>
        <div class="card">
            <p>Teachers</p>
            <h1 class="counter" data-target="6">0</h1>
            <i class="fas fa-chalkboard-teacher card-icon"></i>
        </div>
        <div class="card">
            <p>Available Online Quizzes</p>
            <h1 class="counter" data-target="1">0</h1>
            <i class="fas fa-clipboard-list card-icon"></i>
        </div>
    </div>

    <!-- Improved Action Buttons Container -->
    <div class="action-buttons-container">
        <!-- First row of buttons -->
        <div class="action-buttons">
            <a href="students.jsp" class="btn btn-green">
                <i class="fas fa-user-cog"></i> STUDENT MANAGEMENT
            </a>
            <a href="result" class="btn btn-brown">
                <i class="fas fa-file-alt"></i> EXAM MANAGEMENT
            </a>
            <a href="add_question.jsp" class="btn btn-red">
                <i class="fas fa-plus-square"></i> ADD QUIZ
            </a>
        </div>

        <!-- Second row of buttons -->
        <div class="action-buttons">
            <a href="addResult.jsp" class="btn btn-green">
                <i class="fas fa-plus-circle"></i> ADD SUBMISSION
            </a>
            <a href="results.jsp" class="btn btn-brown">
                <i class="fas fa-edit"></i> EDIT SUBMISSION
            </a>
        </div>
    </div>

    <footer>
        &copy; 2025 PGNO 198, ALL RIGHTS RESERVED.
    </footer>
</div>

<!-- Scripts -->
<script>
    // Counter animation
    const counters = document.querySelectorAll('.counter');
    const speed = 50;

    counters.forEach(counter => {
        const updateCount = () => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;
            const increment = Math.ceil(target / speed);

            if (count < target) {
                counter.innerText = count + increment;
                setTimeout(updateCount, 20);
            } else {
                counter.innerText = target;
            }
        };

        updateCount();
    });

    // Modal functionality
    const openModalBtn = document.getElementById("openModalBtn");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const modal = document.getElementById("studentModal");

    if (openModalBtn && closeModalBtn && modal) {
        openModalBtn.addEventListener("click", () => {
            modal.style.display = "flex";
            setTimeout(() => {
                modal.classList.add("active");
            }, 10);
        });

        function closeModal() {
            modal.classList.remove("active");
            setTimeout(() => {
                modal.style.display = "none";
            }, 300);
        }

        closeModalBtn.addEventListener("click", closeModal);

        window.addEventListener("click", (e) => {
            if (e.target === modal) {
                closeModal();
            }
        });
    }
</script>
</body>
</html>