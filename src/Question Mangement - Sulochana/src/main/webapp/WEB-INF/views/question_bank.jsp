<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Question Bank</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<nav class="bg-blue-900 text-white p-4">
    <div class="container mx-auto flex justify-between items-center">
        <a href="#" class="text-xl font-bold">Online Exam System</a>
        <div class="space-x-4">
            <a href="${pageContext.request.contextPath}/questions" class="hover:text-blue-200">Question Bank</a>
            <a href="${pageContext.request.contextPath}/questions/add" class="hover:text-blue-200">Add Question</a>
        </div>
    </div>
</nav>

<div class="container mx-auto p-6">
    <div class="bg-white shadow rounded-lg p-6">
        <h2 class="text-2xl font-semibold text-gray-800 mb-4">Question Bank</h2>
        <table class="w-full text-left border-collapse">
            <thead>
            <tr class="bg-gray-200">
                <th class="p-3 border-b">ID</th>
                <th class="p-3 border-b">Subject</th>
                <th class="p-3 border-b">Topic</th>
                <th class="p-3 border-b">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="question" items="${questions}">
                <tr class="hover:bg-gray-100">
                    <td class="p-3 border-b">${question.id}</td>
                    <td class="p-3 border-b">${question.subject}</td>
                    <td class="p-3 border-b">${question.topic}</td>
                    <td class="p-3 border-b space-x-2">
                        <a href="${pageContext.request.contextPath}/questions/edit/${question.id}" class="text-green-600 hover:text-green-800">Edit</a>
                        <form action="${pageContext.request.contextPath}/questions/delete/${question.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this question?')">
                            <input type="hidden" name="_method" value="DELETE">
                            <button type="submit" class="text-red-600 hover:text-red-800">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty questions}">
                <tr><td colspan="4" class="p-3 text-center text-gray-500">No questions available.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<footer class="bg-gray-200 text-center p-4 mt-6">
    <p>© 2025 Online Exam System</p>
</footer>
</body>
</html>