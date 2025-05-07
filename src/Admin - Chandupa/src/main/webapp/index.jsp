<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Control</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="sidebar">
    <div>
        <h2>ADMIN CONTROL</h2>
        <nav class="nav-links">
            <a href="register-student.jsp">Register Student</a>
            <a href="edit-student.jsp">Edit Student</a>
            <a href="add-submission.jsp">Add Submission</a>
            <a href="edit-submission.jsp">Edit Submission</a>
        </nav>
    </div>
    <div class="server-status">
        <p>SERVER STATUS</p>
        <p class="usage">USAGE: <span style="color:#33AFFF;">55%</span></p>
    </div>
</div>

<div class="main">
    <div class="top-bar">
        <a href="#">Switch to Teacher View</a>
        <a href="#" class="logout">Logout</a>
    </div>
    <div class="search">
        <label>SEARCH</label>
        <input type="text" placeholder="Search...">
    </div>

    <!-- Stat Cards -->
    <div class="cards">
        <div class="card">
            <p>Total Students</p>
            <h1 class="counter" data-target="167">0</h1>
        </div>
        <div class="card">
            <p>Subjects</p>
            <h1 class="counter" data-target="8">0</h1>
        </div>
        <div class="card">
            <p>Teachers</p>
            <h1 class="counter" data-target="6">0</h1>
        </div>
        <div class="card">
            <p>Available Online Quizes</p>
            <h1 class="counter" data-target="1">0</h1>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="register-student.jsp" class="btn btn-green">+ NEW STUDENT</a>
        <a href="edit-student.jsp" class="btn btn-red">EDIT STUDENT</a>
        <a href="add-submission.jsp" class="btn btn-green">ADD SUBMISSION</a>
        <a href="edit-submission.jsp" class="btn btn-brown">EDIT SUBMISSION</a>
    </div>
</div>

<footer>
    © 2025 PGNO 148, ALL RIGHTS RESERVED.
</footer>

<!-- Counter Animation Script -->
<script>
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
</script>
</body>
</html>
