import 'dart:io';
import 'dart:math';
import 'dart:async';

// Function to get terminal width and height
List<int> getTerminalSize() {
  final result = stdout.terminalColumns;
  final rows = stdout.terminalLines;
  return [result, rows];
}

// Function to clear the terminal
void clearScreen() {
  print("\x1B[2J\x1B[0;0H");
}

// Function to move the cursor to a specific position
void moveCursor(int x, int y) {
  stdout.write('\x1B[${y};${x}H');
}

// Function to fill terminal with background color
void fillScreenWithBackground(String bgColor, int width, int height) {
  stdout.write(bgColor);
  for (int y = 0; y < height; y++) {
    moveCursor(0, y);
    stdout.write(' ' * width); // Fill each line with spaces to color background
  }
  stdout.write('\x1B[0m'); // Reset terminal formatting
}

// Function to generate explosion colors
List<List<String>> getColorPatterns() {
  return [
    ['\x1B[31m', '\x1B[41m'], // Red text on Red background
    ['\x1B[32m', '\x1B[42m'], // Green text on Green background
    ['\x1B[34m', '\x1B[44m'], // Blue text on Blue background
    ['\x1B[35m', '\x1B[45m'], // Magenta text on Magenta background
  ];
}

// Function to animate firework ascent (clearing previous rocket)
Future<void> animateRocket(int xPos, int yStart) async {
  // Define the rocket frames
  List<List<String>> rocketFrames = [
    ['|', '|', '|'], // Frame 1: 3 vertical bars
    ['|', '|'],     // Frame 2: 2 vertical bars
    ['|', '|'],     // Frame 3: 2 vertical bars
    ['|', '|'],     // Frame 4: 2 vertical bars
    ['|', '|', '|'], // Frame 5: 3 vertical bars
  ];

  for (int i = 0; i < rocketFrames.length; i++) {
    clearScreen();
    for (int j = 0; j < rocketFrames[i].length; j++) {
      moveCursor(xPos, yStart - (i + j)); // Move the cursor to the right position
      print(rocketFrames[i][j]); // Print rocket frame
    }
    await Future.delayed(Duration(milliseconds: 300)); // Pause between frames
  }
}

// Function to display explosion
Future<void> displayExplosion(int xPos, int yPos, String color, String bgColor, int width, int height) async {
  clearScreen();

  // Fill screen with background color before showing the explosion
  fillScreenWithBackground(bgColor, width, height);

  // Firework explosion (multi-line)
  stdout.write(color); // Set firework color

  // Firework explosion pattern
  moveCursor(xPos - 30, yPos - 3);
  print("                 \\*        \\   \\             /                                ");
  moveCursor(xPos - 30, yPos - 2);
  print("       '          \\     '* |    |  *        |*                *  *                 ");
  moveCursor(xPos - 30, yPos - 1);
  print("            *      `.       \\   |     *     /    *      '           ");
  moveCursor(xPos - 30, yPos);
  print("  .                  \\      |   \\          /               *                   ");
  moveCursor(xPos - 30, yPos + 1);
  print("     *'  *     '      \\      \\   '.       |                                       ");
  moveCursor(xPos - 30, yPos + 2);
  print("        -._            `                  /         *                              ");
  moveCursor(xPos - 30, yPos + 3);
  print("  ' '      ``._   *                           '          .      '                           ");
  moveCursor(xPos - 30, yPos + 4);
  print("   *           *\\*          * .   .      *                                         ");
  moveCursor(xPos - 30, yPos + 5);
  print("*  '        *    `-._                       .         _..:='        *         ");
  moveCursor(xPos - 30, yPos + 6);
  print("             .  '      *       *    *   .       _.:--'            ");
  moveCursor(xPos - 30, yPos + 7);
  print("           *           .     .     *         .-'         *         ");
  moveCursor(xPos - 30, yPos + 8);
  print("   .               '             . '   *           *                     ");
  moveCursor(xPos - 30, yPos + 9);
  print("  *       ___.-=--..-._     *                '                        ");
  moveCursor(xPos - 30, yPos + 10);
  print("                                  *       *                         ");
  moveCursor(xPos - 30, yPos + 11);
  print("                *        _.'  .'       `.        '  *              ");
  moveCursor(xPos - 30, yPos + 12);
  print("                  *_.-'   .'            `.                                ");
  moveCursor(xPos - 30, yPos + 13);
  print("                   .'                       `._                 ");
  moveCursor(xPos - 30, yPos + 14);
  print("   '       '                        .                               ");

  // Reset color after explosion
  stdout.write('\x1B[0m');
  await Future.delayed(Duration(milliseconds: 1000)); // Hold explosion for one second

  clearScreen(); // Immediately clear screen after explosion
}

// Function to display fireworks
Future<void> displayFireworks(int numberOfFireworks) async {
  final random = Random();
  final termSize = getTerminalSize();
  final width = termSize[0];
  final height = termSize[1];

  final colors = getColorPatterns(); // Color patterns

  for (var i = 0; i < numberOfFireworks; i++) {
    clearScreen();
    
    // Set limits for xPos (20 pixels from left and right edges)
    final xPos = i == 0 
      ? width ~/ 2 
      : random.nextInt(width - 40) + 20; // Ensure xPos is between 20 and (width - 20)

    final yPos = random.nextInt((height ~/ 2) - 10) + 6; // Ensure the explosion is in-bounds

    // Rotate through colors
    final colorPattern = colors[i % colors.length];
    final textColor = colorPattern[0];
    final bgColor = colorPattern[1];

    // Animate rocket rising
    await animateRocket(xPos, height - 6);

    // Pause before explosion (to simulate delay before explosion)
    await Future.delayed(Duration(milliseconds: 500)); // Adjust delay as needed

    // Display explosion with full-screen background
    await displayExplosion(xPos, yPos, textColor, bgColor, width, height);

    await Future.delayed(Duration(seconds: 1)); // Pause before the next firework
  }
}

// Function to display "HBD ANO" in ASCII art
void hbdano() {
  List<String> text = [
    'H       H  B B B B   D D D D  ',
    'H       H  B      B  D      D ',
    'H H H H H  B B B B   D      D ',
    'H       H  B      B  D      D ',
    'H       H  B B B B   D D D D  ',
    '',
    '     A      N     N   O O O O  ',
    '   A   A    N N   N  O        O ',
    '  A A A A   N  N  N  O        O ',
    ' A       A  N   N N  O        O ',
    'A         A N     N   O O O O  ',
  ];

  int terminalHeight = stdout.terminalLines;
  int terminalWidth = stdout.terminalColumns;

  int textHeight = text.length;
  int textWidth = text[0].length;

  int startRow = terminalHeight;

  Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (startRow <= (terminalHeight - textHeight) ~/ 2) {
      timer.cancel();
    } else {
      stdout.write('\x1B[2J\x1B[0;0H'); // Clear screen
      for (int i = 0; i < textHeight; i++) {
        int row = startRow + i;
        if (row >= 0 && row < terminalHeight) {
          int col = (terminalWidth - textWidth) ~/ 2;
          stdout.write('\x1B[${row};${col}H${text[i]}');
        }
      }
      startRow--;
    }
  });
}

// Function to display "HBD ANO" after fireworks
Future<void> displayHBDANO() async {
  // Call animasiAsciiText to start the ASCII text animation
  hbdano();

  // Allow some time for the animation to finish
  await Future.delayed(Duration(seconds: 3));
}

void main() {
  stdout.write("How many fireworks would you like to display? ");
  final input = stdin.readLineSync();
  final numberOfFireworks = int.tryParse(input ?? '') ?? 1;

  displayFireworks(numberOfFireworks).then((_) {
    // After fireworks, display "HBD ANO"
    displayHBDANO();
  });
}
