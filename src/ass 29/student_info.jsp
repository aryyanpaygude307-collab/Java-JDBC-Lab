<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Information - Assignment 29</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #eef2f7 0%, #dbe4ee 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            width: 100%;
            max-width: 600px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .header {
            background: #2563eb;
            color: #ffffff;
            padding: 24px;
            text-align: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 600;
        }
        .header p {
            font-size: 14px;
            opacity: 0.9;
            margin-top: 4px;
        }
        .content {
            padding: 28px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
            margin-bottom: 6px;
        }
        input[type="text"],
        input[type="number"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            color: #1e293b;
            transition: border-color 0.2s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-submit {
            width: 100%;
            background: #2563eb;
            color: white;
            border: none;
            padding: 12px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background: #1d4ed8;
        }
        .card {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            background: #f8fafc;
            padding: 20px;
            margin-top: 10px;
        }
        .card-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }
        .card-row:last-child {
            border-bottom: none;
        }
        .card-label {
            font-weight: 600;
            color: #64748b;
        }
        .card-value {
            color: #0f172a;
            font-weight: 500;
        }
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-success {
            background: #dcfce7;
            color: #15803d;
        }
        .badge-warning {
            background: #fef9c3;
            color: #a16207;
        }
        .badge-danger {
            background: #fee2e2;
            color: #b91c1c;
        }
        .btn-reset {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .btn-reset:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Student Information Portal</h1>
        <p>Assignment 29 - Operation 1</p>
    </div>

    <div class="content">
        <%
            String rollNo = request.getParameter("rollNo");
            String name = request.getParameter("name");
            String course = request.getParameter("course");
            String semester = request.getParameter("semester");
            String email = request.getParameter("email");
            String marksStr = request.getParameter("marks");

            boolean hasSubmitted = (rollNo != null && name != null);

            if (!hasSubmitted) {
        %>
            <!-- Student Information Input Form -->
            <form action="student_info.jsp" method="POST">
                <div class="form-group">
                    <label for="rollNo">Roll Number</label>
                    <input type="number" id="rollNo" name="rollNo" placeholder="e.g. 101" required>
                </div>

                <div class="form-group">
                    <label for="name">Student Full Name</label>
                    <input type="text" id="name" name="name" placeholder="e.g. John Doe" required>
                </div>

                <div class="form-group">
                    <label for="course">Course / Department</label>
                    <select id="course" name="course" required>
                        <option value="">-- Select Course --</option>
                        <option value="Computer Engineering">Computer Engineering</option>
                        <option value="Information Technology">Information Technology</option>
                        <option value="Artificial Intelligence">Artificial Intelligence</option>
                        <option value="Data Science">Data Science</option>
                        <option value="Electronics & Telecommunication">Electronics & Telecommunication</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="semester">Semester</label>
                    <select id="semester" name="semester" required>
                        <option value="Semester 1">Semester 1</option>
                        <option value="Semester 2">Semester 2</option>
                        <option value="Semester 3">Semester 3</option>
                        <option value="Semester 4">Semester 4</option>
                        <option value="Semester 5">Semester 5</option>
                        <option value="Semester 6">Semester 6</option>
                        <option value="Semester 7">Semester 7</option>
                        <option value="Semester 8">Semester 8</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="e.g. john@example.com" required>
                </div>

                <div class="form-group">
                    <label for="marks">Percentage / Marks (%)</label>
                    <input type="number" step="0.01" min="0" max="100" id="marks" name="marks" placeholder="e.g. 88.5" required>
                </div>

                <button type="submit" class="btn-submit">Submit Student Information</button>
            </form>
        <%
            } else {
                double marks = 0.0;
                try {
                    marks = Double.parseDouble(marksStr);
                } catch (Exception ignored) {}

                String gradeBadge;
                String gradeText;
                if (marks >= 75.0) {
                    gradeBadge = "badge-success";
                    gradeText = "Distinction";
                } else if (marks >= 60.0) {
                    gradeBadge = "badge-success";
                    gradeText = "First Class";
                } else if (marks >= 50.0) {
                    gradeBadge = "badge-warning";
                    gradeText = "Second Class";
                } else if (marks >= 40.0) {
                    gradeBadge = "badge-warning";
                    gradeText = "Pass Class";
                } else {
                    gradeBadge = "badge-danger";
                    gradeText = "Fail";
                }
        %>
            <!-- Display Submitted Student Information -->
            <h2 style="font-size: 18px; color: #1e293b; margin-bottom: 14px; text-align: center;">
                Submitted Student Profile
            </h2>

            <div class="card">
                <div class="card-row">
                    <span class="card-label">Roll Number</span>
                    <span class="card-value"><%= rollNo %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Full Name</span>
                    <span class="card-value"><%= name %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Course / Dept</span>
                    <span class="card-value"><%= course %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Semester</span>
                    <span class="card-value"><%= semester %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Email Address</span>
                    <span class="card-value"><%= email %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Percentage</span>
                    <span class="card-value"><%= String.format("%.2f", marks) %>%</span>
                </div>
                <div class="card-row">
                    <span class="card-label">Performance / Grade</span>
                    <span class="card-value"><span class="badge <%= gradeBadge %>"><%= gradeText %></span></span>
                </div>
            </div>

            <a href="student_info.jsp" class="btn-reset">&larr; Enter Another Student Record</a>
        <%
            }
        %>
    </div>
</div>

</body>
</html>