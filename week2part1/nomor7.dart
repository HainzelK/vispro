import 'classVehicle.dart';
import 'dart:io';

void main(List<String> args) {
  print("Pilih:\n1. Mobil\n2. Motor\n");
  int? pilih = int.parse(stdin.readLineSync()!);
  print('==================================================');
  
  switch (pilih) {
    case 1:
    Car car = Car();
    print("Kecepatan : ");
    int? speed = int.parse(stdin.readLineSync()!);
    car.speed = speed;
    car.move();
    break;
    case 2:
    Bike bike = Bike();
    print("Kecepatan : ");
    int? speed = int.parse(stdin.readLineSync()!);
    bike.speed = speed;
    bike.move();
    break;
}
}