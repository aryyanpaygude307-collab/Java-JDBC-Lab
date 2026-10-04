import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class StudentConnection {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.println(
                "Student database (javalab) is connected successfully."
            );

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                "SELECT COUNT(*) FROM student"
            );

            if (rs.next()) {
                System.out.println(
                    "Total students in table: " + rs.getInt(1)
                );
            }

            rs.close();
            stmt.close();
            con.close();

            System.out.println("Connection closed.");

        } catch (Exception e) {
            System.out.println("Connection failed.");
            System.out.println(e.getMessage());
        }
    }
}