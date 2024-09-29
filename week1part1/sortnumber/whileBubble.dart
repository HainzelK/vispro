bool innerBubbleSort(List<int> arr, int n, int i, bool swapped) {
  int j = 0;
  while (j < n - 1 - i) {
    if (arr[j] > arr[j + 1]) {
      // Swap if the element found is greater than the next element
      int temp = arr[j];
      arr[j] = arr[j + 1];
      arr[j + 1] = temp;
      swapped = true;
    }
    j++;
  }
  return swapped;
}