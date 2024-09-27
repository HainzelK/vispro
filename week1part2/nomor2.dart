import 'dart:io';

main(){
  stdout.write("Isi brp per hari: ");
  int tabungan = int.parse(stdin.readLineSync()!);
  int output = tabungan*30;
  print("Hasil tabungan = $output");
}