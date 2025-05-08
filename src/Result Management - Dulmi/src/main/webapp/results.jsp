<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%
    List<String[]> results = (List<String[]>) request.getAttribute("results");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Results Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #0061ff, #60efff);
            --accent-color: #4e54c8;
            --text-color: #000;
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.18);
            --box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            position: relative;
            padding: 2rem 0;
        }

        table tr td{
            color: black;
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

        .bg-shapes:before,
        .bg-shapes:after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            opacity: 0.4;
            filter: blur(100px);
            z-index: -1;
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

        .container {
            position: relative;
            z-index: 1;
        }

        .glass-container {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-title {
            color: var(--text-color);
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

        .results-table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .results-table thead {
            background: rgba(0, 0, 0, 0.2);
        }

        .results-table th {
            color: var(--text-color);
            font-weight: 600;
            padding: 1rem;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            border: none;
            vertical-align: middle;
        }

        .results-table td {
            color: var(--text-color);
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            border-bottom: none;
            font-weight: 500;
        }

        .results-table tbody tr {
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.05);
        }

        .results-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn {
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .btn-icon {
            width: 38px;
            height: 38px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 5px;
        }

        .btn-success {
            background: linear-gradient(45deg, #10B981, #059669);
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #059669, #10B981);
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(16, 185, 129, 0.4);
        }

        .btn-warning {
            background: linear-gradient(45deg, #F59E0B, #D97706);
        }

        .btn-warning:hover {
            background: linear-gradient(45deg, #D97706, #F59E0B);
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(245, 158, 11, 0.4);
        }

        .btn-danger {
            background: linear-gradient(45deg, #EF4444, #DC2626);
        }

        .btn-danger:hover {
            background: linear-gradient(45deg, #DC2626, #EF4444);
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(239, 68, 68, 0.4);
        }

        .grade-badge {
            padding: 5px 10px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            display: inline-block;
            text-align: center;
            min-width: 50px;
        }

        .grade-a-plus {
            background: rgba(16, 185, 129, 0.2);
            color: #10B981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .grade-a {
            background: rgba(59, 130, 246, 0.2);
            color: #3B82F6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .grade-b-plus {
            background: rgba(139, 92, 246, 0.2);
            color: #8B5CF6;
            border: 1px solid rgba(139, 92, 246, 0.3);
        }

        .grade-b {
            background: rgba(245, 158, 11, 0.2);
            color: #F59E0B;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .grade-c-plus, .grade-c {
            background: rgba(249, 115, 22, 0.2);
            color: #F97316;
            border: 1px solid rgba(249, 115, 22, 0.3);
        }

        .grade-d {
            background: rgba(239, 68, 68, 0.2);
            color: #EF4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .grade-f {
            background: rgba(127, 29, 29, 0.2);
            color: #991B1B;
            border: 1px solid rgba(127, 29, 29, 0.3);
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .search-box {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            padding: 8px 20px;
            color: white;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-box:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            width: 280px;
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
        }

        .search-box::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .empty-state {
            text-align: center;
            padding: 3rem 0;
        }

        .empty-state i {
            font-size: 4rem;
            color: rgba(255, 255, 255, 0.3);
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .glass-container {
                padding: 1.5rem;
            }

            .results-table {
                display: block;
                overflow-x: auto;
            }

            .search-box {
                width: 150px;
            }

            .search-box:focus {
                width: 180px;
            }

            .header-actions {
                flex-direction: column;
                align-items: stretch;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="bg-shapes"></div>
<div class="container">
    <div class="glass-container">
        <div class="header-actions">
            <h2 class="page-title">Student Results Dashboard</h2>
            <div class="d-flex align-items-center">
                <input type="text" class="search-box me-3" placeholder="Search results..." id="searchInput">
                <a href="<%= request.getContextPath() %>/addResult" class="btn btn-success">
                    <i class="fas fa-plus me-2"></i>Add New Result
                </a>
            </div>
        </div>

        <% if(results == null || results.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <p>No student results found.</p>
            <a href="<%= request.getContextPath() %>/addResult" class="btn btn-success mt-3">
                <i class="fas fa-plus me-2"></i>Add First Result
            </a>
        </div>
        <% } else { %>
        <div class="table-responsive">
            <table class="table results-table">
                <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Subject Code</th>
                    <th>Subject</th>
                    <th>Credits</th>

                    <th>Attempt</th>
                    <th>Grade</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] result : results) { %>
                <tr>
                    <td><%= result[0] %></td>
                    <td><%= result[1] %></td>
                    <td><%= result[2] %></td>
                    <td><%= result[3] %></td>

                    <td><%= result[5] %></td>
                    <td>
                        <%
                            String grade = result[6];
                            String gradeClass = "";

                            if(grade.equals("A+")) {
                                gradeClass = "grade-a-plus";
                            } else if(grade.equals("A")) {
                                gradeClass = "grade-a";
                            } else if(grade.equals("B+")) {
                                gradeClass = "grade-b-plus";
                            } else if(grade.equals("B")) {
                                gradeClass = "grade-b";
                            } else if(grade.equals("C+")) {
                                gradeClass = "grade-c-plus";
                            } else if(grade.equals("C")) {
                                gradeClass = "grade-c";
                            } else if(grade.equals("D")) {
                                gradeClass = "grade-d";
                            } else if(grade.equals("F")) {
                                gradeClass = "grade-f";
                            }
                        %>
                        <span class="grade-badge <%= gradeClass %>"><%= grade %></span>
                    </td>
                    <td class="text-center">
                        <a href="updateResult?studentId=<%= result[0] %>&subjectCode=<%= result[1] %>"
                           class="btn btn-warning btn-icon" title="Edit">
                            <i class="fas fa-pen"></i>
                        </a>
                        <a href="deleteResult?studentId=<%= result[0] %>&subjectCode=<%= result[1] %>"
                           class="btn btn-danger btn-icon"
                           onclick="return confirm('Are you sure you want to delete this result?');"
                           title="Delete">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const tableRows = document.querySelectorAll('tbody tr');

        if(searchInput) {
            searchInput.addEventListener('keyup', function() {
                const searchTerm = searchInput.value.toLowerCase();

                tableRows.forEach(row => {
                    let found = false;
                    const cells = row.querySelectorAll('td');

                    cells.forEach(cell => {
                        const text = cell.textContent.toLowerCase();
                        if(text.indexOf(searchTerm) > -1) {
                            found = true;
                        }
                    });

                    if(found) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }

        // Add row hover effect
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = '';
            });
        });
    });
</script>
</body>
</html>