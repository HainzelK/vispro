import 'dart:io'; // Library for input/output
import 'dart:async';

class ListNode {
  String? value; // Value stored in the node, nullable for safety
  ListNode? nextNode; // Pointer to the next node, also nullable

  ListNode(this.value); // Constructor to initialize the node with a value
}

Future<void> pause(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

void positionCursor(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

List<int> retrieveScreenSize() {
  return [stdout.terminalColumns, stdout.terminalLines];
}

void clearConsole() {
  print("\x1B[2J\x1B[0;0H"); // Clear entire console, reset cursor to (0, 0)
}

// Function to traverse and display the linked list
void displayList(ListNode head) {
  int index = 1;
  ListNode? current = head; // Start from head (first node)
  while (current != null) {
    stdout.write('${index}. ${current.value}\n'); // Print each node's value
    current = current.nextNode; // Move to the next node
    index++;
  }
}

// Function to insert a new node at a specific position
ListNode insertAtPosition(ListNode head, ListNode newNode, int pos) {
  if (pos == 1) {
    newNode.nextNode = head;
    return newNode; // New node becomes the new head
  }

  ListNode? current = head;
  int index = 1;
  while (current != null && index < pos - 1) {
    current = current.nextNode; // Traverse to the desired position
    index++;
  }

  if (current == null) return head; // Position is out of bounds

  newNode.nextNode = current.nextNode; // Insert new node
  current.nextNode = newNode;

  return head; // Return the updated head
}



ListNode createCycle(ListNode head) {
  ListNode? current = head;
  while (current!.nextNode != null) {
    current = current.nextNode; // Traverse to the last node
  }
  current.nextNode = head; // Create a cycle by linking last node to head
  return head;
}

ListNode setupList() {
  ListNode head = ListNode("h"); // Start with 'h'
  // Insert remaining nodes at the end
  insertAtPosition(head, ListNode("a"), 2); // Now position 2
  insertAtPosition(head, ListNode("i"), 3); // Now position 3
  insertAtPosition(head, ListNode("n"), 4); // Now position 4
  insertAtPosition(head, ListNode("z"), 5); // Now position 5
  insertAtPosition(head, ListNode("e"), 6); // Now position 6
  insertAtPosition(head, ListNode("l"), 7); // Now position 7
  createCycle(head); // Create a cycle if needed
  return head; // Return the head of the list
}


ListNode? getNextNode(ListNode node) {
  return node.nextNode;
}

void main() async {
  ListNode head = setupList();
  clearConsole();

  // Red iteration
  for (int iteration = 0; iteration < 2; iteration++) {
    ListNode? currentNode = head;

    for (int row = 1; row <= retrieveScreenSize()[1]; row++) {
      if (currentNode == null) {
        currentNode = head; // Start with the head node
      }
      if (row % 2 != 0) {
        for (int col = 1; col <= retrieveScreenSize()[0]; col++) {
          positionCursor(row, col);
          stdout.write(currentNode!.value);
          currentNode = getNextNode(currentNode)!;
          await pause(10);
        }
      } else {
        for (int col = retrieveScreenSize()[0]; col > 0; col--) {
          positionCursor(row, col);
          stdout.write(currentNode!.value);
          currentNode = getNextNode(currentNode)!;
          await pause(10);
        }
      }
    }

    // Change text color to red after each iteration
    stdout.write('\x1B[31m'); // ANSI escape code for red text
    positionCursor(1, 1); // Move the cursor back to the top-left corner
    
  }

  // Change text color to blue
  stdout.write('\x1B[34m'); // ANSI escape code for blue text
  positionCursor(1, 1); // Move the cursor back to the top-left corner


  // Display the blue iteration
  for (int row = 1; row <= retrieveScreenSize()[1]; row++) {
    ListNode? currentNode = head;
    if (row % 2 != 0) {
      for (int col = 1; col <= retrieveScreenSize()[0]; col++) {
        positionCursor(row, col);
        stdout.write(currentNode!.value);
        currentNode = getNextNode(currentNode)!;
        await pause(10);
      }
    } else {
      for (int col = retrieveScreenSize()[0]; col > 0; col--) {
        positionCursor(row, col);
        stdout.write(currentNode!.value);
        currentNode = getNextNode(currentNode)!;
        await pause(10);
      }
    }
  }

  // Reset to default color after all iterations are complete
  stdout.write('\x1B[0m'); 
}
