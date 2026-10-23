<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Assignment 29</title>
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
            background: #4338ca;
            color: #ffffff;
            padding: 24px;
            text-align: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
        }
        .header p {
            font-size: 13px;
            opacity: 0.85;
            margin-top: 4px;
        }
        .form-body {
            padding: 28px;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"],
        select {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            color: #1e293b;
            transition: all 0.2s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }
        .radio-group {
            display: flex;
            gap: 20px;
            padding-top: 4px;
        }
        .radio-label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            font-weight: 500;
            color: #475569;
            cursor: pointer;
        }
        .btn-submit {
            width: 100%;
            background: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 13px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background: #4338ca;
        }
        .error-text {
            color: #dc2626;
            font-size: 12px;
            margin-top: 4px;
            display: none;
        }
    </style>
    <script>
        function validateForm() {
            var pass = document.getElementById("password").value;
            var confirmPass = document.getElementById("confirmPassword").value;
            var errorSpan = document.getElementById("passError");

            if (pass !== confirmPass) {
                errorSpan.style.display = "block";
                return false;
            }
            errorSpan.style.display = "none";
            return true;
        }
    </script>
</head>
<body>

<div class="card">
    <div class="header">
        <h1>User Registration</h1>
        <p>Assignment 29 (2) - JSP Registration Portal</p>
    </div>

    <div class="form-body">
        <form action="register_result.jsp" method="POST" onsubmit="return validateForm()">
            <!-- Name -->
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email" id="email" name="email" placeholder="name@example.com" required>
            </div>

            <!-- Phone Number -->
            <div class="form-group">
                <label for="phone">Phone Number *</label>
                <input type="tel" id="phone" name="phone" placeholder="10-digit mobile number" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required>
            </div>

            <!-- Gender -->
            <div class="form-group">
                <label>Gender</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="gender" value="Male" checked> Male
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="gender" value="Female"> Female
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="gender" value="Other"> Other
                    </label>
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">Password *</label>
                <input type="password" id="password" name="password" minlength="6" placeholder="Minimum 6 characters" required>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label for="confirmPassword">Confirm Password *</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
                <span id="passError" class="error-text">Passwords do not match. Please verify.</span>
            </div>

            <button type="submit" class="btn-submit">Register Account</button>
        </form>
    </div>
</div>

</body>
</html>