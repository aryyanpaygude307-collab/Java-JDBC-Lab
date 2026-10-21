import java.io.*;
import java.net.*;

public class ChatServer {
    public static void main(String[] args) {
        try {
            ServerSocket server = new ServerSocket(5000);
            System.out.println("Server started. Waiting for client...");

            Socket socket = server.accept();
            System.out.println("Client connected!");

            BufferedReader input = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(
                socket.getOutputStream(), true);

            BufferedReader keyboard = new BufferedReader(
                new InputStreamReader(System.in));

            String message;

            while ((message = input.readLine()) != null) {
                if (message.equalsIgnoreCase("exit")) {
                    break;
                }

                System.out.println("Client: " + message);
                System.out.print("Reply: ");

                String reply = keyboard.readLine();
                output.println(reply);

                if (reply.equalsIgnoreCase("exit")) {
                    break;
                }
            }

            socket.close();
            server.close();

        } catch (IOException e) {
            System.out.println("Server error: " + e.getMessage());
        }
    }
}