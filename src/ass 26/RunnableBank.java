class BankAccount {
int balance = 1000;


synchronized void deposit(int amount) {
    balance += amount;
    System.out.println(Thread.currentThread().getName()
            + " deposited: " + amount
            + " | Balance: " + balance);
}

synchronized void withdraw(int amount) {
    if (balance >= amount) {
        balance -= amount;
        System.out.println(Thread.currentThread().getName()
                + " withdrew: " + amount
                + " | Balance: " + balance);
    } else {
        System.out.println(Thread.currentThread().getName()
                + " insufficient balance: " + balance);
    }
}


}

class DepositTask implements Runnable {
BankAccount account;


DepositTask(BankAccount account) {
    this.account = account;
}

public void run() {
    account.deposit(500);
    account.deposit(300);
}


}

class WithdrawTask implements Runnable {
BankAccount account;


WithdrawTask(BankAccount account) {
    this.account = account;
}

public void run() {
    account.withdraw(400);
    account.withdraw(200);
}


}

public class RunnableBank {
public static void main(String[] args) {
BankAccount account = new BankAccount();


    Thread t1 = new Thread(new DepositTask(account), "Deposit Thread");
    Thread t2 = new Thread(new WithdrawTask(account), "Withdrawal Thread");

    t1.start();
    t2.start();
}


}
