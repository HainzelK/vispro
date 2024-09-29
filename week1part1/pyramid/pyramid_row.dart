int calculateRows(int input) {
  int rows = 0;
  int totalElements = 0;

  while (totalElements + (rows + 1) <= input) {
    rows++;
    totalElements += rows;
  }

  return rows;
}
