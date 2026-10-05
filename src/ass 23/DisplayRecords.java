import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DisplayRecords {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.println("Database connected successfully.\n");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM student");

            System.out.println("Student Records");
            System.out.println("-----------------------------");

            while (rs.next()) {

                System.out.println("Roll No : " + rs.getInt("roll_no"));
                System.out.println("Name    : " + rs.getString("name"));
                System.out.println("-----------------------------");
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}