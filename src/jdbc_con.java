
import java.sql.Connection;
import java.sql.DriverManager;

public class jdbc_con {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String db = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        try (Connection con = DriverManager.getConnection(db, user, password)) {
            System.out.println("Database connected successfully.");
            con.close();
        } catch (Exception e) {
            System.out.println("Database connection failed.");
        }
    }
}