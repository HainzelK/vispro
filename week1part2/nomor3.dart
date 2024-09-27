import 'dart:io';

main(){
  stdout.write("Diameter lingkaran: ");
  double diameter = double.parse(stdin.readLineSync()!);
  double output = 2*3.14*(diameter/2);
  print("Luas lingkaran adalah $output");
}
