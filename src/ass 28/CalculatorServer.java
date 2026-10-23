import java.rmi.*;
import java.rmi.registry.*;

public class CalculatorServer {
    public static void main(String[] args) {
        try {
            CalculatorImpl calculator = new CalculatorImpl();

            LocateRegistry.createRegistry(1099);

            Naming.rebind("rmi://localhost/Calculator", calculator);

            System.out.println("Calculator RMI Server is running...");
        } catch (Exception e) {
            System.out.println("Server error: " + e.getMessage());
        }
    }
}