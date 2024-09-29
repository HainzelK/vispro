import 'dart:math';

List<int> generateRandomNumbers(int input) {
  List<int> array = [];
  Random random = Random();
  int i = 0;

  while (i < input) {
    int randomNumber = random.nextInt(100);
    array.add(randomNumber);
    i++;
  }

  return array;
}
