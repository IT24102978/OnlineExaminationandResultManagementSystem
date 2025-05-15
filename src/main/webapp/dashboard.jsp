<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.oop_project_analysis.Feedback" %>

<%
    List<Feedback> reviews = (List<Feedback>) request.getAttribute("reviews");
    Map<Integer, Integer> ratingCounts = (Map<Integer, Integer>) request.getAttribute("ratingCounts");
    Double averageRating = (Double) request.getAttribute("averageRating");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Analysis Dashboard</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 20px;
            background-color: #e0f2f7;
            background-image: url('images/elevated-view-laptop-stationeries-blue-backdrop.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
        .data-section { border: 1px solid #ccc; padding: 15px; margin-bottom: 15px; background: rgba(255, 255, 255, 0.9); }
        h2 { color: #007bff; }
        .feedback-item { border-bottom: 1px dashed #ccc; padding-bottom: 10px; margin-bottom: 10px; }
        .feedback-item p { margin-top: 5px; margin-bottom: 5px; }
        .feedback-item strong { font-weight: bold; }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h1>Feedback Analysis Dashboard</h1>

<div class="data-section">
    <h2>Overall Rating Distribution</h2>
    <% if (ratingCounts != null && !ratingCounts.isEmpty()) { %>
    <ul>
        <% for (Map.Entry<Integer, Integer> entry : ratingCounts.entrySet()) { %>
        <li>Rating <%= entry.getKey() %>: <%= entry.getValue() %> feedbacks</li>
        <% } %>
    </ul>

    <canvas id="ratingChart" width="400" height="200"></canvas>
    <script>
        var ratingData = {
            labels: [
                <% int i = 0;
                for (Map.Entry<Integer, Integer> entry : ratingCounts.entrySet()) {
                    if (i++ > 0) out.print(", ");
                    out.print("'Rating " + entry.getKey() + "'");
                } %>
            ],
            datasets: [{
                label: 'Number of Feedbacks',
                data: [
                    <% i = 0;
                    for (Map.Entry<Integer, Integer> entry : ratingCounts.entrySet()) {
                        if (i++ > 0) out.print(", ");
                        out.print(entry.getValue());
                    } %>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        };

        var ctx = document.getElementById('ratingChart').getContext('2d');
        var ratingChart = new Chart(ctx, {
            type: 'bar',
            data: ratingData
        });
    </script>
    <% } else { %>
    <p>No rating data available yet.</p>
    <% } %>
</div>

<div class="data-section">
    <h2>Average Rating</h2>
    <p>The average rating is: <%= averageRating != null ? String.format("%.2f", averageRating) : "N/A" %></p>
</div>

<div class="data-section">
    <h2>Individual Feedback Details</h2>
    <% if (reviews != null && !reviews.isEmpty()) {
        for (Feedback f : reviews) { %>
    <div class="feedback-item">
        <p><strong>Name:</strong> <%= f.getName() %></p>
        <p><strong>Email:</strong> <%= f.getEmail() %></p>
        <p><strong>Feedback:</strong> <%= f.getComments() %></p>
        <p><strong>Rating:</strong> <%= f.getRating() %></p>
    </div>
    <%   }
    } else { %>
    <p>No individual feedback details available.</p>
    <% } %>
</div>

<p><a href="FeedbackIndex.jsp">Go back to the feedback form</a></p>
</body>
</html>
