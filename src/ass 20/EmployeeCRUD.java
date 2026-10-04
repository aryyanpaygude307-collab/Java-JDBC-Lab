import java.sql.*;
import java.util.Scanner;

public class EmployeeCRUD {

    static String db = "jdbc:mysql://localhost:3306/javalab";
    static String user = "root";
    static String password = "ARYYAN@307";

    public static void main(String[] args) throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(db, user, password);

        Scanner sc = new Scanner(System.in);

        int choice;

        do {
            System.out.println("\n===== EMPLOYEE CRUD =====");
            System.out.println("1. Create Employee");
            System.out.println("2. Read Employees");
            System.out.println("3. Update Employee");
            System.out.println("4. Delete Employee");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");

            choice = sc.nextInt();

            switch (choice) {

                case 1:
                    System.out.print("Enter Employee ID: ");
                    int id = sc.nextInt();

                    sc.nextLine();
                    System.out.print("Enter Name: ");
                    String name = sc.nextLine();

                    System.out.print("Enter Department: ");
                    String department = sc.nextLine();

                    System.out.print("Enter Salary: ");
                    double salary = sc.nextDouble();

                    String insert =
                            "INSERT INTO employee VALUES (?, ?, ?, ?)";

                    PreparedStatement ps1 = con.prepareStatement(insert);

                    ps1.setInt(1, id);
                    ps1.setString(2, name);
                    ps1.setString(3, department);
                    ps1.setDouble(4, salary);

                    ps1.executeUpdate();

                    System.out.println("Employee created successfully.");

                    ps1.close();
                    break;

                case 2:

                    Statement stmt = con.createStatement();

                    ResultSet rs =
                            stmt.executeQuery("SELECT * FROM employee");

                    System.out.println("\nEmployee Records");
                    System.out.println("-----------------------------------------");

                    while (rs.next()) {
                        System.out.println(
                                "ID: " + rs.getInt("emp_id") +
                                ", Name: " + rs.getString("name") +
                                ", Department: " + rs.getString("department") +
                                ", Salary: " + rs.getDouble("salary")
                        );
                    }

                    rs.close();
                    stmt.close();
                    break;

                case 3:

                    System.out.print("Enter Employee ID to update: ");
                    int updateId = sc.nextInt();

                    sc.nextLine();
                    System.out.print("Enter New Name: ");
                    String newName = sc.nextLine();

                    System.out.print("Enter New Department: ");
                    String newDepartment = sc.nextLine();

                    System.out.print("Enter New Salary: ");
                    double newSalary = sc.nextDouble();

                    String update =
                            "UPDATE employee SET name=?, department=?, salary=? WHERE emp_id=?";

                    PreparedStatement ps2 =
                            con.prepareStatement(update);

                    ps2.setString(1, newName);
                    ps2.setString(2, newDepartment);
                    ps2.setDouble(3, newSalary);
                    ps2.setInt(4, updateId);

                    int rowsUpdated = ps2.executeUpdate();

                    if (rowsUpdated > 0)
                        System.out.println("Employee updated successfully.");
                    else
                        System.out.println("Employee not found.");

                    ps2.close();
                    break;

                case 4:

                    System.out.print("Enter Employee ID to delete: ");
                    int deleteId = sc.nextInt();

                    String delete =
                            "DELETE FROM employee WHERE emp_id=?";

                    PreparedStatement ps3 =
                            con.prepareStatement(delete);

                    ps3.setInt(1, deleteId);

                    int rowsDeleted = ps3.executeUpdate();

                    if (rowsDeleted > 0)
                        System.out.println("Employee deleted successfully.");
                    else
                        System.out.println("Employee not found.");

                    ps3.close();
                    break;

                case 5:
                    System.out.println("Exiting program...");
                    break;

                default:
                    System.out.println("Invalid choice.");
            }

        } while (choice != 5);

        con.close();
        sc.close();
    }
}