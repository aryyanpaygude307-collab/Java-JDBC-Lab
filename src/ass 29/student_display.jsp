<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Information Display - Assignment 29</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(135deg, #eef2f7 0%, #dbe4ee 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: #ffffff; width: 100%; max-width: 580px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); overflow: hidden; }
        .header { background: #16a34a; color: #ffffff; padding: 22px; text-align: center; }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header p { font-size: 13px; opacity: 0.9; margin-top: 4px; }
        .content { padding: 26px; }
        .card { border: 1px solid #e2e8f0; border-radius: 8px; background: #f8fafc; padding: 18px; }
        .card-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #e2e8f0; font-size: 14px; }
        .card-row:last-child { border-bottom: none; }
        .card-label { font-weight: 600; color: #64748b; }
        .card-value { color: #0f172a; font-weight: 500; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 9999px; font-size: 12px; font-weight: 600; }
        .badge-success { background: #dcfce7; color: #15803d; }
        .badge-warning { background: #fef9c3; color: #a16207; }
        .badge-danger { background: #fee2e2; color: #b91c1c; }
        .btn-back { display: inline-block; width: 100%; text-align: center; background: #2563eb; color: white; padding: 12px; border-radius: 6px; text-decoration: none; font-weight: 600; margin-top: 20px; }
        .btn-back:hover { background: #1d4ed8; }
        .error-box { background: #fee2e2; color: #b91c1c; padding: 14px; border-radius: 6px; text-align: center; font-size: 14px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Student Details Result</h1>
        <p>Assignment 29 (1) - Display Page</p>
    </div>

    <div class="content">
        <%
            String rollNo = request.getParameter("rollNo");
            String name = request.getParameter("name");
            String course = request.getParameter("course");
            String semester = request.getParameter("semester");
            String email = request.getParameter("email");
            String marksStr = request.getParameter("marks");

            if (rollNo == null || name == null) {
        %>
            <div class="error-box">
                No student data received. Please submit the form first.
            </div>
            <a href="student_form.jsp" class="btn-back">Go to Student Entry Form</a>
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
            <div class="card">
                <div class="card-row">
                    <span class="card-label">Roll Number</span>
                    <span class="card-value"><%= rollNo %></span>
                </div>
                <div class="card-row">
                    <span class="card-label">Student Name</span>
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
                    <span class="card-label">Marks / Percentage</span>
                    <span class="card-value"><%= String.format("%.2f", marks) %>%</span>
                </div>
                <div class="card-row">
                    <span class="card-label">Grade Classification</span>
                    <span class="card-value"><span class="badge <%= gradeBadge %>"><%= gradeText %></span></span>
                </div>
            </div>

            <a href="student_form.jsp" class="btn-back">&larr; Enter Another Student</a>
        <%
            }
        %>
    </div>
</div>

</body>
</html>