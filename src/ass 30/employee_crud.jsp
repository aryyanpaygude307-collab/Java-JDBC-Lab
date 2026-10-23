<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System (CRUD) - Assignment 30</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f1f5f9;
            color: #1e293b;
            padding: 30px 20px;
        }
        .container {
            max-width: 1050px;
            margin: 0 auto;
        }
        .header {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            color: white;
            padding: 24px 30px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
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
        .alert-info { background: #e0f2fe; color: #075985; border: 1px solid #bae6fd; }

        .grid-layout {
            display: grid;
            grid-template-columns: 360px 1fr;
            gap: 24px;
            align-items: start;
        }
        @media (max-width: 850px) {
            .grid-layout {
                grid-template-columns: 1fr;
            }
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .panel-title {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 18px;
            color: #0f172a;
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
            color: #475569;
            margin-bottom: 6px;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
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
        .btn-primary { background: #2563eb; color: white; width: 100%; }
        .btn-primary:hover { background: #1d4ed8; }
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
            padding: 12px 14px;
            border-bottom: 2px solid #e2e8f0;
        }
        td {
            padding: 12px 14px;
            border-bottom: 1px solid #e2e8f0;
            color: #1e293b;
        }
        tr:hover {
            background-color: #f8fafc;
        }
        .action-links {
            display: flex;
            gap: 8px;
        }
        .btn-action-edit {
            background: #e0f2fe;
            color: #0369a1;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-action-edit:hover { background: #bae6fd; }
        .btn-action-delete {
            background: #fee2e2;
            color: #b91c1c;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-action-delete:hover { background: #fecaca; }
        .badge {
            background: #e2e8f0;
            color: #475569;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
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
            <h1>Employee Details Management (CRUD)</h1>
            <p>Assignment 30 - Operation 1 | JSP & JDBC MySQL</p>
        </div>
        <div>
            <span class="badge" style="background: rgba(255,255,255,0.2); color: white; padding: 6px 12px; font-size: 13px;">
                Database: javalab
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

        // Variables for edit pre-population
        boolean isEditMode = false;
        String editId = "";
        String editName = "";
        String editDept = "";
        String editSalary = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // Ensure table exists
            Statement initStmt = con.createStatement();
            initStmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS employee (" +
                "emp_id INT PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "department VARCHAR(50) NOT NULL, " +
                "salary DOUBLE NOT NULL)"
            );
            initStmt.close();

            String action = request.getParameter("action");

            // 1. ADD OPERATION
            if ("add".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("emp_id"));
                String name = request.getParameter("name");
                String dept = request.getParameter("department");
                double salary = Double.parseDouble(request.getParameter("salary"));

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO employee (emp_id, name, department, salary) VALUES (?, ?, ?, ?)"
                );
                ps.setInt(1, id);
                ps.setString(2, name);
                ps.setString(3, dept);
                ps.setDouble(4, salary);

                ps.executeUpdate();
                ps.close();

                message = "Employee ID " + id + " (" + name + ") added successfully!";
                messageType = "alert-success";
            }

            // 2. DELETE OPERATION
            else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM employee WHERE emp_id = ?");
                ps.setInt(1, id);
                int rows = ps.executeUpdate();
                ps.close();

                if (rows > 0) {
                    message = "Employee ID " + id + " deleted successfully.";
                    messageType = "alert-success";
                } else {
                    message = "Employee ID " + id + " not found.";
                    messageType = "alert-danger";
                }
            }

            // 3. EDIT LOAD OPERATION
            else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("SELECT * FROM employee WHERE emp_id = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    isEditMode = true;
                    editId = String.valueOf(rs.getInt("emp_id"));
                    editName = rs.getString("name");
                    editDept = rs.getString("department");
                    editSalary = String.valueOf(rs.getDouble("salary"));
                }
                rs.close();
                ps.close();
            }

            // 4. UPDATE OPERATION
            else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("emp_id"));
                String name = request.getParameter("name");
                String dept = request.getParameter("department");
                double salary = Double.parseDouble(request.getParameter("salary"));

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE employee SET name = ?, department = ?, salary = ? WHERE emp_id = ?"
                );
                ps.setString(1, name);
                ps.setString(2, dept);
                ps.setDouble(3, salary);
                ps.setInt(4, id);

                int rows = ps.executeUpdate();
                ps.close();

                if (rows > 0) {
                    message = "Employee ID " + id + " updated successfully!";
                    messageType = "alert-success";
                } else {
                    message = "Could not update Employee ID " + id + ".";
                    messageType = "alert-danger";
                }
            }

        } catch (SQLIntegrityConstraintViolationException ex) {
            message = "Error: An employee with this ID already exists.";
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
        <!-- Form Panel: Add / Update -->
        <div class="panel">
            <div class="panel-title">
                <span><%= isEditMode ? "Update Employee" : "Add New Employee" %></span>
                <% if (isEditMode) { %>
                    <span class="badge" style="background: #fef3c7; color: #92400e;">Editing Mode</span>
                <% } %>
            </div>

            <form action="employee_crud.jsp" method="POST">
                <input type="hidden" name="action" value="<%= isEditMode ? "update" : "add" %>">

                <div class="form-group">
                    <label for="emp_id">Employee ID *</label>
                    <input type="number" id="emp_id" name="emp_id" value="<%= editId %>" <%= isEditMode ? "readonly style='background:#f1f5f9; cursor:not-allowed;'" : "required" %> placeholder="e.g. 101">
                </div>

                <div class="form-group">
                    <label for="name">Employee Name *</label>
                    <input type="text" id="name" name="name" value="<%= editName %>" placeholder="e.g. John Doe" required>
                </div>

                <div class="form-group">
                    <label for="department">Department *</label>
                    <input type="text" id="department" name="department" value="<%= editDept %>" placeholder="e.g. Engineering, Sales, HR" required>
                </div>

                <div class="form-group">
                    <label for="salary">Salary ($ / ₹) *</label>
                    <input type="number" step="0.01" id="salary" name="salary" value="<%= editSalary %>" placeholder="e.g. 75000" required>
                </div>

                <% if (isEditMode) { %>
                    <button type="submit" class="btn btn-warning">Save Changes (Update)</button>
                    <a href="employee_crud.jsp" class="btn btn-cancel">Cancel Edit</a>
                <% } else { %>
                    <button type="submit" class="btn btn-primary">+ Add Employee</button>
                <% } %>
            </form>
        </div>

        <!-- Table Panel: View All Employees -->
        <div class="panel">
            <div class="panel-title">
                <span>Employee Records</span>
                <a href="employee_crud.jsp" style="font-size: 13px; color: #2563eb; text-decoration: none; font-weight: 500;">&#8635; Refresh</a>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Department</th>
                            <th>Salary</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 0;
                            if (con != null) {
                                try {
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT emp_id, name, department, salary FROM employee ORDER BY emp_id ASC");

                                    while (rs.next()) {
                                        count++;
                                        int id = rs.getInt("emp_id");
                                        String name = rs.getString("name");
                                        String dept = rs.getString("department");
                                        double salary = rs.getDouble("salary");
                        %>
                                        <tr>
                                            <td><strong>#<%= id %></strong></td>
                                            <td><%= name %></td>
                                            <td><span class="badge"><%= dept %></span></td>
                                            <td>₹ <%= String.format("%,.2f", salary) %></td>
                                            <td>
                                                <div class="action-links">
                                                    <a href="employee_crud.jsp?action=edit&id=<%= id %>" class="btn-action-edit">Edit</a>
                                                    <a href="employee_crud.jsp?action=delete&id=<%= id %>" class="btn-action-delete" onclick="return confirm('Are you sure you want to delete Employee #<%= id %>?');">Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='5' style='color:red;'>Error fetching records: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    try { con.close(); } catch (Exception ignored) {}
                                }
                            }
                            if (count == 0) {
                        %>
                                <tr>
                                    <td colspan="5" class="empty-state">
                                        No employee records found. Use the form on the left to add one!
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