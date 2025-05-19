<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Submitted</title>
    <style>
        body {
            font-family: sans-serif;
            background-image: url('images/LaptopA.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .confirmation-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #26a69a;
            margin-bottom: 20px;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="confirmation-container">
    <h2>Thank you for your feedback!</h2>
    <p>Your feedback has been successfully submitted.</p>
    <p><a href="FeedbackIndex.jsp">Submit another feedback</a></p>
    <p><a href="FeedbackServlet">View Feedback Dashboard</a></p>
</div>
</body>
</html>
