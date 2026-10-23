import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

public class TemperatureServer {
    public static void main(String[] args) {
        try {
            TemperatureImpl temperature = new TemperatureImpl();

            LocateRegistry.createRegistry(1100);

            Naming.rebind(
                "rmi://localhost:1100/Temperature",
                temperature
            );

            System.out.println("Temperature RMI Server is running...");
        } catch (Exception e) {
            System.out.println("Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}