

import java.sql.*;
import java.util.Scanner;

public class LoginApplication {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        Scanner sc = new Scanner(System.in);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.print("Enter Login ID: ");
            String loginId = sc.nextLine();

            System.out.print("Enter Password: ");
            String pass = sc.nextLine();

            String query = "SELECT * FROM staff WHERE login_id = ? AND password = ?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, loginId);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("\nLogin Successful!");
                System.out.println("Welcome, " + rs.getString("login_id"));
            } else {
                System.out.println("\nInvalid Login ID or Password.");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }

        sc.close();
    }
}