class Bank {
int balance = 1000;


synchronized void deposit(int amount) {
    balance += amount;

    System.out.println(
        Thread.currentThread().getName()
        + " deposited: " + amount
        + " | Balance: " + balance
    );
}

synchronized void withdraw(int amount) {
    if (balance >= amount) {
        balance -= amount;

        System.out.println(
            Thread.currentThread().getName()
            + " withdrew: " + amount
            + " | Balance: " + balance
        );
    } else {
        System.out.println(
            Thread.currentThread().getName()
            + " cannot withdraw: " + amount
            + " | Insufficient balance: " + balance
        );
    }
}


}

class DepositThread extends Thread {
Bank bank;


DepositThread(Bank bank) {
    this.bank = bank;
}

public void run() {
    bank.deposit(500);
    bank.deposit(300);
}


}

class WithdrawThread extends Thread {
Bank bank;


WithdrawThread(Bank bank) {
    this.bank = bank;
}

public void run() {
    bank.withdraw(400);
    bank.withdraw(200);
}


}

public class BankTransactions {
public static void main(String[] args) {
Bank bank = new Bank();


    DepositThread t1 = new DepositThread(bank);
    WithdrawThread t2 = new WithdrawThread(bank);

    t1.setName("Deposit Thread");
    t2.setName("Withdrawal Thread");

    t1.start();
    t2.start();
}


}
