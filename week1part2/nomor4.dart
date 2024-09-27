import 'dart:io';

void main(List<String> args) {
  stdout.write("Celcius: ");
  double celcius= double.parse(stdin.readLineSync()!);
  double output = (9/5)*celcius+32;
  print('Fahrenheitnya = $output');
}