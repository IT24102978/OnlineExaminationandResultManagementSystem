<!DOCTYPE html>
<html>
<head>
  <title>Update Result</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #667eea, #764ba2);
      padding: 40px 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .glass-container {
      background: rgba(255, 255, 255, 0.15 );
      backdrop-filter: blur(10px);
      border-radius: 20px;
      border: 1px solid rgba(255, 255, 255, 0.18);
      box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
      padding: 30px;
      margin-bottom: 30px;
    }

    .form-label {
      color: #fff;
      font-weight: 500;
      letter-spacing: 0.5px;
    }

    .page-title {
      color: white;
      text-align: center;
      margin-bottom: 30px;
      font-weight: 600;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
    }

    .form-control, .form-select {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.3);
      border-radius: 10px;
      color: #fff;
      font-weight: 500;
      padding: 12px;
    }

    .form-control:focus, .form-select:focus {
      box-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
      background: rgba(255, 255, 255, 0.3);
      border-color: rgba(255, 255, 255, 0.6);
      color: #fff;
    }

    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.7);
    }

    .form-control[readonly] {
      background: rgba(255, 255, 255, 0.1);
    }

    .btn {
      padding: 10px 25px;
      border-radius: 30px;
      font-weight: 600;
      letter-spacing: 0.5px;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      border: none;
      box-shadow: 0 4px 15px rgba(42, 118, 252, 0.4);
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #5700c9, #1461e8);
      transform: translateY(-2px);
      box-shadow: 0 6px 18px rgba(42, 118, 252, 0.5);
    }

    .btn-danger {
      background: linear-gradient(135deg, #f06, #d62976);
      border: none;
      box-shadow: 0 4px 15px rgba(255, 0, 102, 0.4);
    }

    .btn-danger:hover {
      background: linear-gradient(135deg, #e50058, #c12568);
      transform: translateY(-2px);
      box-shadow: 0 6px 18px rgba(255, 0, 102, 0.5);
    }

    .action-buttons {
      display: flex;
      justify-content: flex-end;
      gap: 15px;
      margin-top: 20px;
    }

    .section-title {
      color: white;
      border-bottom: 1px solid rgba(255, 255, 255, 0.2);
      padding-bottom: 8px;
      margin-bottom: 15px;
      font-size: 18px;
    }

    option {
      background-color: #764ba2;
      color: white;
    }

    .form-icon {
      margin-right: 8px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2 class="page-title"><i class="fas fa-edit form-icon"></i>Update Student Result</h2>

  <div class="glass-container">
    <form action="submitUpdateResult" method="post">
      <div class="section-title"><i class="fas fa-user form-icon"></i>Student Information</div>
      <!-- Row 1 -->
      <div class="row mb-4">
        <div class="col-md-12">
          <label for="studentName" class="form-label">Student Name:</label>
          <div class="input-group">
            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-user-graduate"></i></span>
            <input type="text" id="studentName" name="studentName" class="form-control" value="<%= request.getAttribute("studentName") %>" readonly>
          </div>
        </div>
      </div>

      <div class="section-title"><i class="fas fa-book form-icon"></i>Subject Information</div>
      <!-- Row 2 -->
      <div class="row mb-4">
        <div class="col-md-6">
          <label for="subjectCode" class="form-label">Subject Code:</label>
          <div class="input-group">
            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-hashtag"></i></span>
            <input type="text" id="subjectCode" name="subjectCode" class="form-control" value="<%= request.getAttribute("subjectCode") %>" readonly>
          </div>
        </div>
        <div class="col-md-6">
          <label for="subject" class="form-label">Subject:</label>
          <div class="input-group">
            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-book-open"></i></span>
            <input type="text" id="subject" name="subject" class="form-control" value="<%= request.getAttribute("subject") %>" readonly>
          </div>
        </div>
      </div>

      <div class="section-title"><i class="fas fa-chart-bar form-icon"></i>Performance Details</div>
      <!-- Row 3 -->
      <div class="row mb-4">
        <div class="col-md-3">
          <label for="Marks" class="form-label">Marks:</label>
          <div class="input-group">
            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-star"></i></span>
            <input type="number" id="Marks" name="Marks" class="form-control" value="<%= request.getAttribute("Marks") %>" required>
          </div>
        </div>
<%--        <div class="col-md-3">--%>
<%--          <label for="ca" class="form-label">CA%:</label>--%>
<%--          <div class="input-group">--%>
<%--            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-percentage"></i></span>--%>
<%--            <input type="number" id="ca" name="ca" class="form-control" value="<%= request.getAttribute("ca") %>" required>--%>
<%--          </div>--%>
<%--        </div>--%>

        <div class="col-md-3">
          <label for="grade" class="form-label">Grade:</label>
          <div class="input-group">
            <span class="input-group-text" style="background: rgba(255, 255, 255, 0.2); border: 1px solid rgba(255, 255, 255, 0.3); color: white;"><i class="fas fa-award"></i></span>
            <select id="grade" name="grade" class="form-select" required>
              <option value="A+" <%= "A+".equals(request.getAttribute("grade")) ? "selected" : "" %>>A+</option>
              <option value="A" <%= "A".equals(request.getAttribute("grade")) ? "selected" : "" %>>A</option>
              <option value="B+" <%= "B+".equals(request.getAttribute("grade")) ? "selected" : "" %>>B+</option>
              <option value="B" <%= "B".equals(request.getAttribute("grade")) ? "selected" : "" %>>B</option>
              <option value="C+" <%= "C+".equals(request.getAttribute("grade")) ? "selected" : "" %>>C+</option>
              <option value="C" <%= "C".equals(request.getAttribute("grade")) ? "selected" : "" %>>C</option>
              <option value="D" <%= "D".equals(request.getAttribute("grade")) ? "selected" : "" %>>D</option>
              <option value="F" <%= "F".equals(request.getAttribute("grade")) ? "selected" : "" %>>F</option>
            </select>
          </div>
        </div>
      </div>

      <input type="hidden" name="studentName" value="<%= request.getAttribute("studentName") %>">
      <input type="hidden" name="subjectCode" value="<%= request.getAttribute("subjectCode") %>">

      <div class="action-buttons">
        <a href="<%= request.getContextPath() %>/result" class="btn btn-danger"><i class="fas fa-arrow-left me-2"></i>Back</a>
        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Update Result</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>