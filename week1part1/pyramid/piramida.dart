import 'dart:io';
import 'dart:math';
import 'random_number.dart';
import 'pyramid_row.dart';
import 'print_pyramid.dart';

void main() {
  stdout.write('masukkan angka: ');
  int input = int.parse(stdin.readLineSync()!);

  List<int> array = generateRandomNumbers(input);
  print(array);

  int rows = calculateRows(input);
  printTriangle(array, rows, input);
}
