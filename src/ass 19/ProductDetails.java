import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class ProductDetails {

    public static void main(String[] args) throws Exception {

        String db = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(db, user, password);

        System.out.println("Database connected successfully.\n");

        String query = "SELECT pid, pname, quantity, price FROM product";

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        System.out.println("Product Details");
        System.out.println("---------------------------------------------");

        while (rs.next()) {
            System.out.println("Product ID   : " + rs.getInt("pid"));
            System.out.println("Product Name : " + rs.getString("pname"));
            System.out.println("Quantity     : " + rs.getInt("quantity"));
            System.out.println("Price        : " + rs.getDouble("price"));
            System.out.println("---------------------------------------------");
        }

        rs.close();
        stmt.close();
        con.close();
    }
}