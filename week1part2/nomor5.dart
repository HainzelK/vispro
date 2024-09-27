import 'dart:io';
void main(List<String> args) {
  stdout.write("Jam parkir: ");
  int jam = int.parse(stdin.readLineSync()!);
  if (jam>2){
    int output = 4000+1000*(jam-2);
    print('Biaya parkir = $output');
  }
  else {
    int output = 2000*jam;
    print('Biaya parkir = $output');
  }

}