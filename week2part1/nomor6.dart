import 'dart:io';

void main(List<String> args) {
  print("Celcius : ");
  int celcius = int.parse(stdin.readLineSync()!);
  print("Pilih:\n1. Reamur\n2. Fahrenheit\n3. Kelvin\n");
  int? pilih = int.parse(stdin.readLineSync()!);
  print('==================================================');
  switch (pilih) {
    case 1:
    double Reamur = celcius* (4/5);
    print("Temperatur sekarang $Reamur °R");
    break;
    case 2:
    double Fahrenheit = (celcius* 9/5) + 32;
    print("Temperatur sekarang $Fahrenheit °F");
    break;
    case 3:
    double Kelvin = celcius+ 273.15;
    print("Temperatur sekarang $Kelvin K");
    break;
}
}