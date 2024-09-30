class BankAccount {
  int? _balance;
  int? get getBalance => _balance;

  set balance(int? balance) {
    _balance = balance;
  }
}

class SavingsAccount extends BankAccount {
  void interest() {
    double interestRate = 0.1;
    double interestAmount = getBalance! * interestRate;
    balance = getBalance! + interestAmount.toInt(); 
    print("kalau ada interest : $getBalance");
  }
}