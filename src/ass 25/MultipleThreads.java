class NumberThread extends Thread {
    String name;

    NumberThread(String name) {
        this.name = name;
    }

    public void run() {
        for (int i = 1; i <= 5; i++) {
            System.out.println(name + " prints: " + i);

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                System.out.println(e);
            }
        }
    }
}

public class MultipleThreads {
    public static void main(String[] args) {
        NumberThread t1 = new NumberThread("Thread 1");
        NumberThread t2 = new NumberThread("Thread 2");
        NumberThread t3 = new NumberThread("Thread 3");

        t1.start();
        t2.start();
        t3.start();
    }
}