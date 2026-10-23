<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Entry Form - Assignment 29</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(135deg, #eef2f7 0%, #dbe4ee 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: #ffffff; width: 100%; max-width: 580px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); overflow: hidden; }
        .header { background: #2563eb; color: #ffffff; padding: 22px; text-align: center; }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header p { font-size: 13px; opacity: 0.9; margin-top: 4px; }
        .content { padding: 26px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-weight: 600; font-size: 14px; color: #334155; margin-bottom: 6px; }
        input[type="text"], input[type="number"], input[type="email"], select {
            width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; color: #1e293b;
        }
        input:focus, select:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15); }
        .btn-submit { width: 100%; background: #2563eb; color: white; border: none; padding: 12px; font-size: 15px; font-weight: 600; border-radius: 6px; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #1d4ed8; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Student Information Form</h1>
        <p>Assignment 29 (1) - Data Entry</p>
    </div>

    <div class="content">
        <form action="student_display.jsp" method="POST">
            <div class="form-group">
                <label for="rollNo">Roll Number</label>
                <input type="number" id="rollNo" name="rollNo" placeholder="Enter roll number (e.g. 101)" required>
            </div>

            <div class="form-group">
                <label for="name">Student Full Name</label>
                <input type="text" id="name" name="name" placeholder="Enter full name" required>
            </div>

            <div class="form-group">
                <label for="course">Course / Department</label>
                <select id="course" name="course" required>
                    <option value="">-- Select Course --</option>
                    <option value="Computer Engineering">Computer Engineering</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Artificial Intelligence">Artificial Intelligence</option>
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
                <input type="email" id="email" name="email" placeholder="student@example.com" required>
            </div>

            <div class="form-group">
                <label for="marks">Percentage / Marks (%)</label>
                <input type="number" step="0.01" min="0" max="100" id="marks" name="marks" placeholder="e.g. 85.50" required>
            </div>

            <button type="submit" class="btn-submit">Submit Details</button>
        </form>
    </div>
</div>

</body>
</html>