import 'dart:io';

void main(List<String> args) {
  stdout.write("AC: ");

  double ac= double.parse(stdin.readLineSync()!);
   stdout.write("TV: ");
  double tv= double.parse(stdin.readLineSync()!);
  stdout.write("Lampu: ");
  double lampu= double.parse(stdin.readLineSync()!);
  double output1 = 1.5*ac;
  double output2 = 0.2*tv;
  double output3 = 0.1*lampu;
  double output4 = output1+output2+output3;
  print('AC = $output1 kWh \nTV = $output2 \nLampu = $output3 \nTotal = $output4');
}