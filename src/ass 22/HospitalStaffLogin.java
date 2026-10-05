

import java.sql.*;
import java.util.Scanner;

public class HospitalStaffLogin {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/javalab";
        String user = "root";
        String password = "ARYYAN@307";

        Scanner sc = new Scanner(System.in);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.println("===== HOSPITAL STAFF LOGIN =====");

            System.out.print("Enter Login ID: ");
            String loginId = sc.nextLine();

            System.out.print("Enter Password: ");
            String pass = sc.nextLine();

            String query = "SELECT role FROM staff WHERE login_id = ? AND password = ?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, loginId);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String role = rs.getString("role");

                System.out.println("\nLogin Successful!");

                if (role.equalsIgnoreCase("Doctor")) {
                    System.out.println("Access Granted: Doctor");
                    System.out.println("Welcome Doctor. You can access patient records.");

                } else if (role.equalsIgnoreCase("Nurse")) {
                    System.out.println("Access Granted: Nurse");
                    System.out.println("Welcome Nurse. You can access nursing services.");

                } else {
                    System.out.println("Access Granted: " + role);
                }

            } else {
                System.out.println("\nAccess Denied!");
                System.out.println("Invalid Login ID or Password.");
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