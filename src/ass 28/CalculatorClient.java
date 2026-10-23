import java.rmi.*;
import java.util.Scanner;

public class CalculatorClient {
    public static void main(String[] args) {
        try {
            Calculator calculator = (Calculator)
                Naming.lookup("rmi://localhost/Calculator");

            Scanner sc = new Scanner(System.in);

            System.out.print("Enter first number: ");
            double a = sc.nextDouble();

            System.out.print("Enter second number: ");
            double b = sc.nextDouble();

            System.out.println("Addition: " + calculator.add(a, b));
            System.out.println("Subtraction: " + calculator.subtract(a, b));
            System.out.println("Multiplication: " + calculator.multiply(a, b));

            if (b != 0) {
                System.out.println("Division: " + calculator.divide(a, b));
            } else {
                System.out.println("Division: Cannot divide by zero");
            }

            sc.close();
        } catch (Exception e) {
            System.out.println("Client error: " + e.getMessage());
        }
    }
}