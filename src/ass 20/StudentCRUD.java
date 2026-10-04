import java.sql.*;
import java.util.Scanner;

public class StudentCRUD {

    static String db = "jdbc:mysql://localhost:3306/javalab";
    static String user = "root";
    static String password = "ARYYAN@307";

    public static void main(String[] args) throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(db, user, password);

        Scanner sc = new Scanner(System.in);

        int choice;

        do {
            System.out.println("\n===== STUDENT CRUD =====");
            System.out.println("1. Create Student");
            System.out.println("2. Read Students");
            System.out.println("3. Update Student");
            System.out.println("4. Delete Student");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");

            choice = sc.nextInt();

            switch (choice) {

                case 1:

                    System.out.print("Enter Roll Number: ");
                    int rollNo = sc.nextInt();

                    sc.nextLine();
                    System.out.print("Enter Name: ");
                    String name = sc.nextLine();

                    System.out.print("Enter Course: ");
                    String course = sc.nextLine();

                    System.out.print("Enter Marks: ");
                    double marks = sc.nextDouble();

                    String insert =
                            "INSERT INTO student_crud VALUES (?, ?, ?, ?)";

                    PreparedStatement ps1 =
                            con.prepareStatement(insert);

                    ps1.setInt(1, rollNo);
                    ps1.setString(2, name);
                    ps1.setString(3, course);
                    ps1.setDouble(4, marks);

                    ps1.executeUpdate();

                    System.out.println("Student created successfully.");

                    ps1.close();
                    break;

                case 2:

                    Statement stmt = con.createStatement();

                    ResultSet rs =
                            stmt.executeQuery("SELECT * FROM student_crud");

                    System.out.println("\nStudent Records");
                    System.out.println("-----------------------------------------");

                    while (rs.next()) {
                        System.out.println(
                                "Roll No: " + rs.getInt("roll_no") +
                                ", Name: " + rs.getString("name") +
                                ", Course: " + rs.getString("course") +
                                ", Marks: " + rs.getDouble("marks")
                        );
                    }

                    rs.close();
                    stmt.close();
                    break;

                case 3:

                    System.out.print("Enter Roll Number to update: ");
                    int updateRoll = sc.nextInt();

                    sc.nextLine();
                    System.out.print("Enter New Name: ");
                    String newName = sc.nextLine();

                    System.out.print("Enter New Course: ");
                    String newCourse = sc.nextLine();

                    System.out.print("Enter New Marks: ");
                    double newMarks = sc.nextDouble();

                    String update =
                            "UPDATE student_crud SET name=?, course=?, marks=? WHERE roll_no=?";

                    PreparedStatement ps2 =
                            con.prepareStatement(update);

                    ps2.setString(1, newName);
                    ps2.setString(2, newCourse);
                    ps2.setDouble(3, newMarks);
                    ps2.setInt(4, updateRoll);

                    int rowsUpdated = ps2.executeUpdate();

                    if (rowsUpdated > 0)
                        System.out.println("Student updated successfully.");
                    else
                        System.out.println("Student not found.");

                    ps2.close();
                    break;

                case 4:

                    System.out.print("Enter Roll Number to delete: ");
                    int deleteRoll = sc.nextInt();

                    String delete =
                            "DELETE FROM student_crud WHERE roll_no=?";

                    PreparedStatement ps3 =
                            con.prepareStatement(delete);

                    ps3.setInt(1, deleteRoll);

                    int rowsDeleted = ps3.executeUpdate();

                    if (rowsDeleted > 0)
                        System.out.println("Student deleted successfully.");
                    else
                        System.out.println("Student not found.");

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