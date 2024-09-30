import 'dart:io';
import 'classAccount.dart';


void deposit(BankAccount bank) {
  print("Deposit brp? ");
  int deposit = int.parse(stdin.readLineSync()!);

  if (deposit < 50000) {
    print("Minimum deposit adalah 50,000.");
    return;
  }

  bank.balance = deposit + (bank.getBalance ?? 0);
}

void withdraw(BankAccount bank) {
  print('Tarik brp? ');
  int withdraw = int.parse((stdin.readLineSync()!));


  if (withdraw < 50000) {
    print("Minimum withdrawal adalah 50,000.");
    return;
  }

  bank.balance = (bank.getBalance ?? 0) - withdraw;
}

void check(BankAccount bank) {
  print("Current balance: ${bank.getBalance}");
}

void main() {
  var bank = SavingsAccount();
  print("Pilih :\n 1. Deposit\n 2. Withdraw\n 3. Cek Isi\n 4. Interest");
  int? pilih = int.parse(stdin.readLineSync()!);
  print("Isi akun : ");
  bank.balance = int.parse(stdin.readLineSync()!);

  switch (pilih) {
    case 1:
      deposit(bank);
      print("Hasil: ${bank.getBalance}");
      break;
    case 2:
      withdraw(bank);
      print("Hasil : ${bank.getBalance}");
      break;
    case 3:
      check(bank);
      break;
    case 4:
      bank.interest();
      break;
  }
}
