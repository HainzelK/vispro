import 'dart:io';
void main(List<String> args) {
  stdout.write("Jam kerja: ");
  int jam = int.parse(stdin.readLineSync()!);
  if (jam>40){
    int output = 4000000+200000*(jam-40);
    print('Gaji = $output');
  }
  else {
    int output = 4000000;
    print('Gaji = $output');
  }

}