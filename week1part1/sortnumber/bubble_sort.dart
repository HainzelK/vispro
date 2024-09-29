import 'whileBubble.dart'; // Import the inner bubble sort function

void bubbleSort(List<int> arr) {
  int n = arr.length;
  bool swapped = true;
  int i = 0;

  while (swapped) {
    swapped = false;
    // Call the helper function to handle the inner loop logic
    swapped = innerBubbleSort(arr, n, i, swapped);
    i++;
  }
}
