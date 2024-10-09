import 'dart:io';
import 'dart:async';

class Element {
  String content;
  Element? next;

  Element(this.content);
}

class CircularLinkedList {
  Element? head;

  void append(String content) {
    final newElement = Element(content);
    if (head == null) {
      head = newElement;
      head!.next = head;
    } else {
      newElement.next = head!.next;
      head!.next = newElement;
      head = newElement;
    }
  }

  String getNext(Element current) {
    return current.next!.content;
  }
}

Future<void> pause(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

void moveCursor(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

List<int> getScreenSize() {
  return [stdout.terminalColumns, stdout.terminalLines];
}

void clearScreen() {
  print("\x1B[2J\x1B[H");
}

void setColor(String color) {
  final colors = {
    'default': '\x1B[0m',
    'red': '\x1B[31m',
    'blue': '\x1B[34m',
  };
  stdout.write(colors[color] ?? colors['default']);
}

CircularLinkedList initializeList() {
  final list = CircularLinkedList();
  'hainzel'.split('').forEach(list.append);
  return list;
}

Future<void> displayPattern(CircularLinkedList list) async {
  final screenSize = getScreenSize();
  Element? current = list.head!.next; // Start from the first element

  for (int row = 1; row <= screenSize[1]; row++) {
    // Write white text in the row
    if (row % 2 != 0) {
      // Left to right
      for (int col = 1; col <= screenSize[0]; col++) {
        moveCursor(row, col);
        stdout.write(current!.content); // Write current element
        current = current.next;
        await pause(10);
      }
    } else {
      // Right to left
      for (int col = screenSize[0]; col > 0; col--) {
        moveCursor(row, col);
        stdout.write(current!.content); // Write current element
        current = current.next;
        await pause(10);
      }
    }
  }
}

Future<void> overlayText(CircularLinkedList list, String color) async {
  final screenSize = getScreenSize();
  Element? current = list.head!.next; // Start from the first element

  setColor(color); // Set the color for overlay

  for (int row = 1; row <= screenSize[1]; row++) {
    moveCursor(row, 1); // Move cursor to the beginning of the line
    if (row % 2 != 0) {
      // Odd row (Left to Right for overlay)
      for (int col = 1; col <= screenSize[0]; col++) {
        stdout.write(current!.content); // Overlay red text for odd row
        current = current.next;
        await pause(10);
      }
    } else {
      // Even row (Right to Left for overlay)
      for (int col = screenSize[0]; col > 0; col--) {
        moveCursor(row, col); // Move cursor to the column before writing
        stdout.write(current!.content); // Overlay red text for even row
        current = current.next;
        await pause(10);
      }
    }
  }

  setColor('default'); // Reset color to default after overlay
}

void main() async {
  final list = initializeList();
  clearScreen();

  // Default color iteration
  await displayPattern(list);
  await pause(2000);

  // Overlay red text without clearing the screen
  await overlayText(list, 'red'); // Overlay with red text
  await pause(2000);

  // Overlay blue text (optional) without clearing the screen
  await overlayText(list, 'blue'); // Overlay with blue text

  // Reset color
  setColor('default');
}
