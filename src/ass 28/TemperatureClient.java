import java.rmi.*;
import java.util.Scanner;

public class TemperatureClient {
    public static void main(String[] args) {
        try {
            Temperature temperature = (Temperature)
                Naming.lookup("rmi://localhost:1100/Temperature");

            Scanner sc = new Scanner(System.in);

            System.out.println("1. Celsius to Fahrenheit");
            System.out.println("2. Fahrenheit to Celsius");
            System.out.print("Choose conversion: ");
            int choice = sc.nextInt();

            System.out.print("Enter temperature: ");
            double value = sc.nextDouble();

            if (choice == 1) {
                double result = temperature.celsiusToFahrenheit(value);
                System.out.println("Temperature in Fahrenheit: " + result);
            } else if (choice == 2) {
                double result = temperature.fahrenheitToCelsius(value);
                System.out.println("Temperature in Celsius: " + result);
            } else {
                System.out.println("Invalid choice");
            }

            sc.close();
        } catch (Exception e) {
            System.out.println("Client error: " + e.getMessage());
        }
    }
}