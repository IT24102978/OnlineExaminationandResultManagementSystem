<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Student Result</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0061ff, #60efff);
            position: relative;
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            padding: 2rem 0;
        }

        /* Pattern overlay */
        body:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image:
                    radial-gradient(circle at 25px 25px, rgba(255, 255, 255, 0.2) 2%, transparent 0%),
                    radial-gradient(circle at 75px 75px, rgba(255, 255, 255, 0.2) 2%, transparent 0%);
            background-size: 100px 100px;
            pointer-events: none;
            z-index: 0;
        }

        .container {
            position: relative;
            z-index: 1;
        }

        .glass-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            padding: 2.5rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .form-label {
            color: white;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
        }

        .page-title {
            color: white;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

        .page-title:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: linear-gradient(90deg, rgba(255,255,255,0.7) 0%, rgba(255,255,255,0) 100%);
            bottom: 0;
            left: 25%;
            border-radius: 10px;
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            font-weight: 500;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.25);
            color: white;
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .btn {
            padding: 10px 25px;
            font-weight: 600;
            letter-spacing: 0.5px;
            border-radius: 30px;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(45deg, #6366F1, #8B5CF6);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #8B5CF6, #6366F1);
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(99, 102, 241, 0.6);
        }

        .btn-danger {
            background: linear-gradient(45deg, #F43F5E, #E11D48);
            box-shadow: 0 4px 15px rgba(244, 63, 94, 0.4);
        }

        .btn-danger:hover {
            background: linear-gradient(45deg, #E11D48, #F43F5E);
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(244, 63, 94, 0.6);
        }

        .form-icon {
            position: absolute;
            right: 15px;
            top: 45px;
            color: rgba(255, 255, 255, 0.7);
        }

        .input-group-icon {
            position: relative;
        }

        select option {
            background-color: #333;
            color: white;
        }

        /* Animated background shapes */
        .bg-shapes:before,
        .bg-shapes:after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            opacity: 0.4;
            filter: blur(100px);
        }

        .bg-shapes:before {
            background: #ff3d71;
            top: -100px;
            left: -100px;
            animation: float1 10s infinite ease-in-out;
        }

        .bg-shapes:after {
            background: #ffaa00;
            bottom: -100px;
            right: -100px;
            animation: float2 13s infinite ease-in-out;
        }

        @keyframes float1 {
            0% { transform: translate(0, 0); }
            50% { transform: translate(40px, 40px); }
            100% { transform: translate(0, 0); }
        }

        @keyframes float2 {
            0% { transform: translate(0, 0); }
            50% { transform: translate(-40px, -40px); }
            100% { transform: translate(0, 0); }
        }

        @media (max-width: 768px) {
            .glass-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="bg-shapes"></div>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="glass-container">
                <h2 class="page-title text-center">Add Student Exam Result</h2>
                <form action="submitResultServlet" method="get" class="row g-4">
                    <!-- Student Name -->
                    <div class="col-md-6 input-group-icon">
                        <label for="studentName" class="form-label">
                            <i class="fas fa-user-graduate me-2"></i>Student Name
                        </label>
                        <select name="studentID" id="studentID" class="form-select" required>
                            <option value="">Select Student</option>
                            <%
                                List<String[]> students = (List<String[]>) request.getAttribute("students");
                                if (students != null) {
                                    for (String[] student : students) {
                            %>
                            <option value="<%= student[0] %>"><%= student[1] + " " +student[2] %></option>
                            <%
                                }
                            } else {
                            %>
                            <option disabled>No students found</option>
                            <%
                                }
                            %>
                        </select>
                        <i class="fas fa-chevron-down form-icon"></i>
                    </div>

                    <!-- Subject Code -->
                    <div class="col-md-6 input-group-icon">
                        <label for="subjectCode" class="form-label">
                            <i class="fas fa-book me-2"></i>Subject Code
                        </label>
                        <select name="subjectCode" id="subjectCode" class="form-select" required>
                            <option value="">Select Subject</option>
                            <%
                                List<String[]> subjects = (List<String[]>) request.getAttribute("subjects");
                                if (subjects != null) {
                                    for (String[] subject : subjects) {
                            %>
                            <option value="<%= subject[0] %>"><%= subject[1] %></option>
                            <%
                                }
                            } else {
                            %>
                            <option disabled>No Subjects found</option>
                            <%
                                }
                            %>
                        </select>
                        <i class="fas fa-chevron-down form-icon"></i>
                    </div>

                    <!-- Marks -->
                    <div class="col-md-6 input-group-icon">
                        <label for="Marks" class="form-label">
                            <i class="fas fa-star me-2"></i>Marks
                        </label>
                        <input type="number" class="form-control" id="Marks" name="Marks" min="1" required>
                        <i class="fas fa-hashtag form-icon"></i>
                    </div>

                    <!-- Grade -->
                    <div class="col-md-6 input-group-icon">
                        <label for="grade" class="form-label">
                            <i class="fas fa-award me-2"></i>Grade
                        </label>
                        <select class="form-select" id="grade" name="grade" required>
                            <option value="">Select Grade</option>
                            <option value="A+">A+</option>
                            <option value="A">A</option>
                            <option value="B+">B+</option>
                            <option value="B">B</option>
                            <option value="C+">C+</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                            <option value="F">F</option>
                        </select>
                        <i class="fas fa-chevron-down form-icon"></i>
                    </div>

                    <!-- Submit Buttons -->
                    <div class="col-12 text-center mt-4">
                        <a href="result" class="btn btn-danger me-3">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Submit Result
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add animation when the page loads
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelector('.glass-container').style.opacity = '0';
        setTimeout(() => {
            document.querySelector('.glass-container').style.transition = 'all 0.8s ease';
            document.querySelector('.glass-container').style.opacity = '1';
        }, 300);
    });

    // Form validation enhancement
    const form = document.querySelector('form');
    form.addEventListener('submit', function(event) {
        const inputs = form.querySelectorAll('input, select');
        let isValid = true;

        inputs.forEach(input => {
            if (!input.validity.valid) {
                input.classList.add('is-invalid');
                isValid = false;
            } else {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
            }
        });

        if (!isValid) {
            event.preventDefault();
            alert('Please fill all required fields correctly.');
        }
    });

    // Clear validation classes on input
    const inputs = form.querySelectorAll('input, select');
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            input.classList.remove('is-invalid');
        });
    });
</script>
</body>
</html>