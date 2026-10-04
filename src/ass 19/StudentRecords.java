import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class StudentRecords {

    public static void main(String[] args) throws Exception {

        // Database connection details
        String db = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        Connection con = DriverManager.getConnection(db, user, password);

        System.out.println("Database connected successfully.\n");

        // SELECT query
        String query = "SELECT * FROM student";

        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery(query);

        // Display student records
        System.out.println("Student Records");
        System.out.println("-----------------------------");

        while (rs.next()) {

            System.out.println("Roll No : " + rs.getInt("roll_no"));
            System.out.println("Name    : " + rs.getString("name"));
            System.out.println("-----------------------------");
        }

        // Close resources
        rs.close();
        stmt.close();
        con.close();
    }
}