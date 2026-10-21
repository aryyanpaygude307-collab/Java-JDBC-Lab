import java.io.*;
import java.net.*;

public class ChatClient {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 5000);
            System.out.println("Connected to server!");

            BufferedReader input = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(
                socket.getOutputStream(), true);

            BufferedReader keyboard = new BufferedReader(
                new InputStreamReader(System.in));

            String message;

            while (true) {
                System.out.print("You: ");
                message = keyboard.readLine();

                output.println(message);

                if (message.equalsIgnoreCase("exit")) {
                    break;
                }

                String reply = input.readLine();

                if (reply == null) {
                    break;
                }

                System.out.println("Server: " + reply);

                if (reply.equalsIgnoreCase("exit")) {
                    break;
                }
            }

            socket.close();

        } catch (IOException e) {
            System.out.println("Client error: " + e.getMessage());
        }
    }
}