<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Confirmation - Assignment 29</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 24px;
        }
        .card {
            background: #ffffff;
            width: 100%;
            max-width: 520px;
            border-radius: 14px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }
        .header {
            background: #16a34a;
            color: #ffffff;
            padding: 24px;
            text-align: center;
        }
        .header .icon {
            font-size: 40px;
            margin-bottom: 8px;
        }
        .header h1 {
            font-size: 22px;
            font-weight: 700;
        }
        .header p {
            font-size: 13px;
            opacity: 0.9;
            margin-top: 4px;
        }
        .body-content {
            padding: 28px;
        }
        .table-details {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }
        .table-details tr {
            border-bottom: 1px solid #f1f5f9;
        }
        .table-details tr:last-child {
            border-bottom: none;
        }
        .table-details th {
            text-align: left;
            padding: 12px 6px;
            font-size: 13px;
            font-weight: 600;
            color: #64748b;
            width: 40%;
        }
        .table-details td {
            padding: 12px 6px;
            font-size: 14px;
            font-weight: 500;
            color: #0f172a;
        }
        .badge {
            display: inline-block;
            background: #dcfce7;
            color: #15803d;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-return {
            display: block;
            text-align: center;
            background: #4f46e5;
            color: #ffffff;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-return:hover {
            background: #4338ca;
        }
        .toggle-btn {
            background: none;
            border: 1px solid #cbd5e1;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 11px;
            cursor: pointer;
            margin-left: 6px;
            color: #475569;
        }
        .toggle-btn:hover {
            background: #f1f5f9;
        }
        .error-card {
            background: #fee2e2;
            color: #b91c1c;
            padding: 16px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
    <script>
        function togglePassword() {
            var passSpan = document.getElementById("passDisplay");
            var btn = document.getElementById("toggleBtn");
            if (passSpan.getAttribute("data-masked") === "true") {
                passSpan.textContent = passSpan.getAttribute("data-real");
                passSpan.setAttribute("data-masked", "false");
                btn.textContent = "Hide";
            } else {
                passSpan.textContent = passSpan.getAttribute("data-stars");
                passSpan.setAttribute("data-masked", "true");
                btn.textContent = "Show";
            }
        }
    </script>
</head>
<body>

<div class="card">
    <%
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean isValid = (name != null && !name.trim().isEmpty() &&
                           email != null && !email.trim().isEmpty() &&
                           phone != null && !phone.trim().isEmpty() &&
                           password != null && !password.trim().isEmpty());

        if (!isValid) {
    %>
        <div class="header" style="background: #dc2626;">
            <div class="icon">&#9888;</div>
            <h1>Registration Incomplete</h1>
            <p>Required registration fields were missing.</p>
        </div>
        <div class="body-content">
            <div class="error-card">
                Please complete all required fields on the registration page before submitting.
            </div>
            <a href="register.jsp" class="btn-return">&larr; Return to Registration Form</a>
        </div>
    <%
        } else {
            String masked = "";
            for (int i = 0; i < password.length(); i++) {
                masked += "&bull;";
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
            String registrationTime = sdf.format(new Date());
    %>
        <div class="header">
            <div class="icon">&#10004;</div>
            <h1>Registration Successful!</h1>
            <p>User account has been submitted and registered</p>
        </div>

        <div class="body-content">
            <table class="table-details">
                <tr>
                    <th>Registration Status</th>
                    <td><span class="badge">Verified Active</span></td>
                </tr>
                <tr>
                    <th>Full Name</th>
                    <td><%= name %></td>
                </tr>
                <tr>
                    <th>Email Address</th>
                    <td><%= email %></td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td>+91 <%= phone %></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><%= (gender != null ? gender : "Not specified") %></td>
                </tr>
                <tr>
                    <th>Submitted Password</th>
                    <td>
                        <span id="passDisplay" data-masked="true" data-real="<%= password %>" data-stars="<%= masked %>">
                            <%= masked %>
                        </span>
                        <button type="button" id="toggleBtn" class="toggle-btn" onclick="togglePassword()">Show</button>
                    </td>
                </tr>
                <tr>
                    <th>Registration Time</th>
                    <td><%= registrationTime %></td>
                </tr>
            </table>

            <a href="register.jsp" class="btn-return">&larr; Register Another User</a>
        </div>
    <%
        }
    %>
</div>

</body>
</html>