import 'dart:io';
import 'dart:math';
import 'bubble_sort.dart';

main(){
  Stopwatch waktu = Stopwatch();
  stdout.write("Berapa banyak angka : ");
  int input = int.parse(stdin.readLineSync()!);
  List<int> array = [];
  Random random = Random();
  int i=0;

  while(i++ < input){
    int randomNumber = random.nextInt(100);
    array.add(randomNumber);
  }
  print(array.join(', '));

  stdout.write("Pilih coy \n 1. Bubble Sort \n 2. Inverse \n 3. Shuffle \n Pilihan anda : ");
  String? jawab = stdin.readLineSync();
    switch (jawab){
    case "1":
      waktu.start();
      bubbleSort(array);
      print(array.join(', '));
      waktu.stop();
      print("Waktu eksekusi : ${waktu.elapsedMilliseconds} ms");
      break;
    case "2":
      waktu.start();
      print(array.reversed.toList().join(', '));
      waktu.stop();
      print("Waktu eksekusi : ${waktu.elapsedMilliseconds} ms");
      break;
    case "3":
      waktu.start();
      array.shuffle();
      print(array.join(', '));
      waktu.stop();
      print("Waktu eksekusi : ${waktu.elapsedMilliseconds} ms");
      break;
  }}