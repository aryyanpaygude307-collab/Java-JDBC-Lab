<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Records Management System (CRUD) - Assignment 30</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f0fdf4;
            color: #0f172a;
            padding: 30px 20px;
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
        }
        .header {
            background: linear-gradient(135deg, #047857 0%, #10b981 100%);
            color: white;
            padding: 24px 30px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 4px 15px rgba(4, 120, 87, 0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
        }
        .header p {
            font-size: 13px;
            opacity: 0.9;
            margin-top: 4px;
        }
        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .alert-danger { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }

        .grid-layout {
            display: grid;
            grid-template-columns: 370px 1fr;
            gap: 24px;
            align-items: start;
        }
        @media (max-width: 880px) {
            .grid-layout {
                grid-template-columns: 1fr;
            }
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }
        .panel-title {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 18px;
            color: #065f46;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        input[type="number"],
        select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #10b981;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
        }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-success { background: #059669; color: white; width: 100%; }
        .btn-success:hover { background: #047857; }
        .btn-warning { background: #d97706; color: white; width: 100%; }
        .btn-warning:hover { background: #b45309; }
        .btn-cancel {
            display: block;
            text-align: center;
            background: #e2e8f0;
            color: #334155;
            margin-top: 10px;
            padding: 8px;
        }
        .btn-cancel:hover { background: #cbd5e1; }

        .table-responsive {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th {
            background-color: #f8fafc;
            color: #475569;
            font-weight: 600;
            text-align: left;
            padding: 12px 12px;
            border-bottom: 2px solid #e2e8f0;
        }
        td {
            padding: 12px 12px;
            border-bottom: 1px solid #e2e8f0;
            color: #1e293b;
        }
        tr:hover {
            background-color: #f0fdf4;
        }
        .action-links {
            display: flex;
            gap: 6px;
        }
        .btn-action-edit {
            background: #e0f2fe;
            color: #0369a1;
            padding: 4px 8px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-action-edit:hover { background: #bae6fd; }
        .btn-action-delete {
            background: #fee2e2;
            color: #b91c1c;
            padding: 4px 8px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-action-delete:hover { background: #fecaca; }

        .badge-status {
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        .status-admitted { background: #fee2e2; color: #b91c1c; }
        .status-treatment { background: #e0f2fe; color: #0284c7; }
        .status-observation { background: #fef3c7; color: #b45309; }
        .status-discharged { background: #dcfce7; color: #15803d; }
        .status-recovered { background: #ccfbf1; color: #0f766e; }

        .empty-state {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h1>Hospital Patient Records Management</h1>
            <p>Assignment 30 - Operation 2 | JSP CRUD Application</p>
        </div>
        <div>
            <span style="background: rgba(255,255,255,0.25); color: white; padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 600;">
                Healthcare System
            </span>
        </div>
    </div>

    <%
        String dbUrl = "jdbc:mysql://localhost:3306/javalab";
        String dbUser = "root";
        String dbPass = "ARYYAN@307";

        Connection con = null;
        String message = null;
        String messageType = null;

        boolean isEditMode = false;
        String editId = "";
        String editName = "";
        String editAge = "";
        String editDisease = "";
        String editStatus = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // Auto create patient table if not exists
            Statement initStmt = con.createStatement();
            initStmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS patient (" +
                "patient_id INT PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "age INT NOT NULL, " +
                "disease VARCHAR(100) NOT NULL, " +
                "treatment_status VARCHAR(50) NOT NULL)"
            );
            initStmt.close();

            String action = request.getParameter("action");

            // 1. ADD PATIENT
            if ("add".equalsIgnoreCase(action)) {
                int patientId = Integer.parseInt(request.getParameter("patient_id"));
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                String disease = request.getParameter("disease");
                String treatmentStatus = request.getParameter("treatment_status");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO patient (patient_id, name, age, disease, treatment_status) VALUES (?, ?, ?, ?, ?)"
                );
                ps.setInt(1, patientId);
                ps.setString(2, name);
                ps.setInt(3, age);
                ps.setString(4, disease);
                ps.setString(5, treatmentStatus);

                ps.executeUpdate();
                ps.close();

                message = "Patient record #" + patientId + " (" + name + ") registered successfully!";
                messageType = "alert-success";
            }

            // 2. DELETE PATIENT
            else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM patient WHERE patient_id = ?");
                ps.setInt(1, id);
                int rows = ps.executeUpdate();
                ps.close();

                if (rows > 0) {
                    message = "Patient record #" + id + " deleted successfully.";
                    messageType = "alert-success";
                } else {
                    message = "Patient ID " + id + " not found.";
                    messageType = "alert-danger";
                }
            }

            // 3. EDIT LOAD
            else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE patient_id = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    isEditMode = true;
                    editId = String.valueOf(rs.getInt("patient_id"));
                    editName = rs.getString("name");
                    editAge = String.valueOf(rs.getInt("age"));
                    editDisease = rs.getString("disease");
                    editStatus = rs.getString("treatment_status");
                }
                rs.close();
                ps.close();
            }

            // 4. UPDATE PATIENT
            else if ("update".equalsIgnoreCase(action)) {
                int patientId = Integer.parseInt(request.getParameter("patient_id"));
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                String disease = request.getParameter("disease");
                String treatmentStatus = request.getParameter("treatment_status");

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE patient SET name = ?, age = ?, disease = ?, treatment_status = ? WHERE patient_id = ?"
                );
                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, disease);
                ps.setString(4, treatmentStatus);
                ps.setInt(5, patientId);

                int rows = ps.executeUpdate();
                ps.close();

                if (rows > 0) {
                    message = "Patient record #" + patientId + " updated successfully!";
                    messageType = "alert-success";
                } else {
                    message = "Failed to update record for Patient #" + patientId + ".";
                    messageType = "alert-danger";
                }
            }

        } catch (SQLIntegrityConstraintViolationException ex) {
            message = "Error: A patient with ID " + request.getParameter("patient_id") + " already exists.";
            messageType = "alert-danger";
        } catch (Exception e) {
            message = "Database Error: " + e.getMessage();
            messageType = "alert-danger";
        }
    %>

    <% if (message != null) { %>
        <div class="alert <%= messageType %>">
            <%= message %>
        </div>
    <% } %>

    <div class="grid-layout">
        <!-- Patient Form: Add / Edit -->
        <div class="panel">
            <div class="panel-title">
                <span><%= isEditMode ? "Update Patient Details" : "Register New Patient" %></span>
                <% if (isEditMode) { %>
                    <span style="font-size: 12px; background: #fef3c7; color: #92400e; padding: 2px 8px; border-radius: 4px;">Edit Mode</span>
                <% } %>
            </div>

            <form action="patient_crud.jsp" method="POST">
                <input type="hidden" name="action" value="<%= isEditMode ? "update" : "add" %>">

                <div class="form-group">
                    <label for="patient_id">Patient ID *</label>
                    <input type="number" id="patient_id" name="patient_id" value="<%= editId %>" <%= isEditMode ? "readonly style='background:#f1f5f9; cursor:not-allowed;'" : "required" %> placeholder="e.g. 501">
                </div>

                <div class="form-group">
                    <label for="name">Patient Full Name *</label>
                    <input type="text" id="name" name="name" value="<%= editName %>" placeholder="e.g. Sarah Connor" required>
                </div>

                <div class="form-group">
                    <label for="age">Age (Years) *</label>
                    <input type="number" min="0" max="130" id="age" name="age" value="<%= editAge %>" placeholder="e.g. 42" required>
                </div>

                <div class="form-group">
                    <label for="disease">Diagnosed Disease / Condition *</label>
                    <input type="text" id="disease" name="disease" value="<%= editDisease %>" placeholder="e.g. Hypertension, Viral Fever" required>
                </div>

                <div class="form-group">
                    <label for="treatment_status">Treatment Status *</label>
                    <select id="treatment_status" name="treatment_status" required>
                        <option value="">-- Select Status --</option>
                        <option value="Admitted" <%= "Admitted".equalsIgnoreCase(editStatus) ? "selected" : "" %>>Admitted</option>
                        <option value="Under Treatment" <%= "Under Treatment".equalsIgnoreCase(editStatus) ? "selected" : "" %>>Under Treatment</option>
                        <option value="Under Observation" <%= "Under Observation".equalsIgnoreCase(editStatus) ? "selected" : "" %>>Under Observation</option>
                        <option value="Discharged" <%= "Discharged".equalsIgnoreCase(editStatus) ? "selected" : "" %>>Discharged</option>
                        <option value="Recovered" <%= "Recovered".equalsIgnoreCase(editStatus) ? "selected" : "" %>>Recovered</option>
                    </select>
                </div>

                <% if (isEditMode) { %>
                    <button type="submit" class="btn btn-warning">Update Patient Record</button>
                    <a href="patient_crud.jsp" class="btn btn-cancel">Cancel Edit</a>
                <% } else { %>
                    <button type="submit" class="btn btn-success">+ Register Patient</button>
                <% } %>
            </form>
        </div>

        <!-- Patients Table -->
        <div class="panel">
            <div class="panel-title">
                <span>Active Patient Records</span>
                <a href="patient_crud.jsp" style="font-size: 13px; color: #059669; text-decoration: none; font-weight: 500;">&#8635; Refresh List</a>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Patient ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Disease</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int patientCount = 0;
                            if (con != null) {
                                try {
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT patient_id, name, age, disease, treatment_status FROM patient ORDER BY patient_id ASC");

                                    while (rs.next()) {
                                        patientCount++;
                                        int pid = rs.getInt("patient_id");
                                        String pName = rs.getString("name");
                                        int pAge = rs.getInt("age");
                                        String pDisease = rs.getString("disease");
                                        String pStatus = rs.getString("treatment_status");

                                        String badgeClass = "status-treatment";
                                        if ("Admitted".equalsIgnoreCase(pStatus)) {
                                            badgeClass = "status-admitted";
                                        } else if ("Under Observation".equalsIgnoreCase(pStatus)) {
                                            badgeClass = "status-observation";
                                        } else if ("Discharged".equalsIgnoreCase(pStatus)) {
                                            badgeClass = "status-discharged";
                                        } else if ("Recovered".equalsIgnoreCase(pStatus)) {
                                            badgeClass = "status-recovered";
                                        }
                        %>
                                        <tr>
                                            <td><strong>#<%= pid %></strong></td>
                                            <td><%= pName %></td>
                                            <td><%= pAge %> yrs</td>
                                            <td><%= pDisease %></td>
                                            <td>
                                                <span class="badge-status <%= badgeClass %>"><%= pStatus %></span>
                                            </td>
                                            <td>
                                                <div class="action-links">
                                                    <a href="patient_crud.jsp?action=edit&id=<%= pid %>" class="btn-action-edit">Edit</a>
                                                    <a href="patient_crud.jsp?action=delete&id=<%= pid %>" class="btn-action-delete" onclick="return confirm('Are you sure you want to delete Patient #<%= pid %>?');">Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='6' style='color:red;'>Error fetching patient records: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    try { con.close(); } catch (Exception ignored) {}
                                }
                            }
                            if (patientCount == 0) {
                        %>
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        No patient records found in the system. Register a new patient using the form.
                                    </td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>