import java.io.*;
import java.net.*;

public class EchoClient {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 5001);

            BufferedReader input = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(
                socket.getOutputStream(), true);

            BufferedReader keyboard = new BufferedReader(
                new InputStreamReader(System.in));

            System.out.print("Enter a message: ");
            String message = keyboard.readLine();

            output.println(message);

            String response = input.readLine();

            System.out.println("Server response: " + response);

            socket.close();

        } catch (IOException e) {
            System.out.println("Client error: " + e.getMessage());
        }
    }
}