class Task1 implements Runnable {
public void run() {
for (int i = 1; i <= 5; i++) {
System.out.println("Task 1: " + i);


        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            System.out.println(e);
        }
    }
}


}

class Task2 implements Runnable {
public void run() {
for (int i = 1; i <= 5; i++) {
System.out.println("Task 2: " + i);


        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            System.out.println(e);
        }
    }
}


}

public class RunnableTasks {
public static void main(String[] args) {
Thread t1 = new Thread(new Task1());
Thread t2 = new Thread(new Task2());


    t1.start();
    t2.start();
}


}
