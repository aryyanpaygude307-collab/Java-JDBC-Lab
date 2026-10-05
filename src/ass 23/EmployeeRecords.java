import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class EmployeeRecords {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.println("Database connected successfully.\n");

            Statement stmt = con.createStatement();

            String query = "SELECT emp_id, name, department, salary FROM employee";

            ResultSet rs = stmt.executeQuery(query);

            System.out.println("Employee Records");
            System.out.println("-----------------------------------------");

            while (rs.next()) {

                System.out.println("Employee ID : " + rs.getInt("emp_id"));
                System.out.println("Name        : " + rs.getString("name"));
                System.out.println("Department  : " + rs.getString("department"));
                System.out.println("Salary      : " + rs.getDouble("salary"));
                System.out.println("-----------------------------------------");
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}