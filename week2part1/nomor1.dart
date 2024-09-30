import 'dart:io';
import 'classStudent.dart';

void main(List<String> args) {
  stdout.write("NAMA: ");
  Student.name = stdin.readLineSync()!;
  stdout.write("ID: ");
  Student.studentID = int.parse(stdin.readLineSync()!);
  stdout.write("Nilai: ");
  Student.grade= int.parse(stdin.readLineSync()!);

  displayInfo();
  cekNilai();
}

void displayInfo(){
  print("==============================");
  print("Nama Siswa ${Student.name}");
  print("ID Siswa ${Student.studentID}");
  print("Nilai Siswa ${Student.grade}");
  print("==============================");

}

void cekNilai(){
  if (Student.grade!>70){
    print("Anda selamat");
  }
  else{
    print('Anda tidak selamat');
  }
}