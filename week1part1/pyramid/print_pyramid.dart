void printTriangle(List<int> array, int rows, int input) {
  int index = 0;
  int currentRow = 0;

  while (currentRow < rows) {
    String spaces = ' ' * (rows - currentRow - 1);
    String line = spaces; 

    int currentColumn = 0;
    while (currentColumn <= currentRow) {
      if (index < input) {
        line += '${array[index++]}   ';
      }
      currentColumn++;
    }

    print(line.trimRight());
    currentRow++;
  }
}
