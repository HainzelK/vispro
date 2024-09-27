import "dart:io";


main(){
  stdout.write("Kg Apel: ");
  int apel = int.parse(stdin.readLineSync()!);
  stdout.write("Kg Jeruk: ");
  int jeruk = int.parse(stdin.readLineSync()!);
  int output = jeruk*4000 + apel*5000;
  print("Total harga = $output");
}