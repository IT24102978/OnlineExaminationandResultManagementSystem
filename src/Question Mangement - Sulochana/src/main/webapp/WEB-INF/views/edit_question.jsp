<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Question</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function toggleOptions() {
            const type = document.getElementById('type').value;
            document.getElementById('options-group').style.display = type === 'MCQ' ? 'block' : 'none';
        }
        document.addEventListener('DOMContentLoaded', toggleOptions);
    </script>
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
        <h2 class="text-2xl font-semibold text-gray-800 mb-4">Edit Question</h2>
        <form action="${pageContext.request.contextPath}/questions/update" method="post" class="space-y-4">
            <input type="hidden" name="id" value="${question.id}">
            <div>
                <label for="type" class="block text-sm font-medium text-gray-700">Question Type</label>
                <select id="type" name="type" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" onchange="toggleOptions()">
                    <option value="MCQ" ${question.type == 'MCQ' ? 'selected' : ''}>Multiple Choice (MCQ)</option>
                    <option value="Descriptive" ${question.type == 'Descriptive' ? 'selected' : ''}>Descriptive</option>
                </select>
            </div>
            <div>
                <label for="topic" class="block text-sm font-medium text-gray-700">Topic</label>
                <input type="text" id="topic" name="topic" value="${question.topic}" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>
            <div>
                <label for="subject" class="block text-sm font-medium text-gray-700">Subject</label>
                <input type="text" id="subject" name="subject" value="${question.subject}" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>
            <div>
                <label for="text" class="block text-sm font-medium text-gray-700">Question Text</label>
                <textarea id="text" name="text" rows="3" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">${question.text}</textarea>
            </div>
            <div id="options-group" class="${question.type == 'MCQ' ? '' : 'hidden'}">
                <label for="options" class="block text-sm font-medium text-gray-700">Options (comma-separated for MCQ)</label>
                <input type="text" id="options" name="options" value="${question.options}" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>
            <div>
                <label for="correctAnswer" class="block text-sm font-medium text-gray-700">Correct Answer</label>
                <input type="text" id="correctAnswer" name="correctAnswer" value="${question.correctAnswer}" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700">Update Question</button>
        </form>
    </div>
</div>

<footer class="bg-gray-200 text-center p-4 mt-6">
    <p>© 2025 Online Exam System</p>
</footer>
</body>
</html>