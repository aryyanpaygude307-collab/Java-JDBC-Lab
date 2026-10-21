import java.io.*;
import java.net.*;

public class EchoServer {
    public static void main(String[] args) {
        try {
            ServerSocket server = new ServerSocket(5001);
            System.out.println("Echo server started. Waiting for client...");

            Socket socket = server.accept();
            System.out.println("Client connected!");

            BufferedReader input = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(
                socket.getOutputStream(), true);

            String message = input.readLine();

            System.out.println("Received: " + message);
            output.println(message);

            System.out.println("Echo sent: " + message);

            socket.close();
            server.close();

        } catch (IOException e) {
            System.out.println("Server error: " + e.getMessage());
        }
    }
}