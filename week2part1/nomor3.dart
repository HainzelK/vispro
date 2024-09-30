import 'dart:io';
import 'classATM.dart';

void deposit(ATM bank){
  print("Deposit brp? ");
  int deposit = int.parse(stdin.readLineSync()!);
  if (deposit < 50000) {
  print("Minimum deposit is 50,000.");
  return;
  }
  
  bank.balance = deposit+(bank.getBalance ?? 0);
  
}

void withdraw(ATM bank){
  print('Tarik brp? ');
  int withdraw = int.parse((stdin.readLineSync()!));
  if (withdraw < 50000) {
  print("Minimum withdrawal is 50,000.");
  return;
  }
  
  bank.balance = (bank.getBalance ?? 0 )-withdraw;
}

void check(ATM bank){
  bank.getBalance;
}

void main(){
  var bank = ATM();
  print("Brp tabungan anda : ");
  bank.balance = int.parse(stdin.readLineSync()!);
  print("Pilih :\n 1. Deposit\n 2. Withdraw\n 3. Cek Isi");
  int? pilih = int.parse(stdin.readLineSync()!);
  switch(pilih){
    case 1 : 
    deposit(bank);
    print("Hasil: ${bank.getBalance}");
    break;
    case 2 : 
    withdraw(bank);
    print("Hasil : ${bank.getBalance}");
    break;
    case 3 : 
    check(bank);
    break;
    }
}