import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.DatabaseMetaData;

public class jdbc_con {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Driver loaded.");

            Connection con = DriverManager.getConnection(url, user, password);

            DatabaseMetaData meta = con.getMetaData();

            System.out.println("Connection Status: CONNECTED");
            System.out.println("Database Product : " + meta.getDatabaseProductName());
            System.out.println("URL              : " + url);
            System.out.println();

            System.out.println(
                "Student database (javalab) is connected successfully."
            );

            con.close();

        } catch (Exception e) {
            System.out.println("Connection failed.");
            System.out.println(e.getMessage());
        }
    }
}