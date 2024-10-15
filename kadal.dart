import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

// Constants for the game configuration
const int boardHeight = 20;
const int boardWidth = 40;
const String foodSymbol = '@';
const String lizardSymbol = '*';
const String emptySpace = ' ';

// Directions: up, down, left, right
final List<List<int>> directions = [
  [-1, 0], // up
  [1, 0],  // down
  [0, -1], // left
  [0, 1],  // right
];

/// Marking Position as final to comply with Dart's class modifiers
final class Position extends LinkedListEntry<Position> {
  int x, y;

  Position(this.x, this.y);

  bool equals(Position other) => x == other.x && y == other.y;
}

class LizardGame {
  final List<List<String>> board;
  final LinkedList<Position> lizard;
  late Position food;
  bool isGameOver = false;
  final Random random = Random();

  LizardGame()
      : board = List.generate(boardHeight, (_) => List.filled(boardWidth, emptySpace)),
        lizard = LinkedList<Position>() {
    _initializeLizard();
    _placeFood();
    _drawBoard();
  }


  void _initializeLizard() {
    int centerX = boardHeight ~/ 2;
    int centerY = boardWidth ~/ 2;

    lizard.clear(); // Clear any existing segments

    // Add arms on the upper side
    lizard.add(Position(centerX - 2, centerY - 2)); // Upper left arm
    lizard.add(Position(centerX - 2, centerY - 1)); // Upper left arm
    lizard.add(Position(centerX - 2, centerY));     // Upper left arm
    lizard.add(Position(centerX - 2, centerY + 1)); // Upper left arm
    lizard.add(Position(centerX - 2, centerY + 2)); // Upper left arm

    // Upper star (body)
    lizard.add(Position(centerX - 1, centerY));

    // Upper horizontal line
    for (int dy = -2; dy <= 2; dy++) {
      lizard.add(Position(centerX - 1, centerY + dy));
    }

    // Middle star (body)
    lizard.add(Position(centerX, centerY));

    // Lower horizontal line
    for (int dy = -2; dy <= 2; dy++) {
      lizard.add(Position(centerX + 1, centerY + dy));
    }

    // Lower star (body)
    lizard.add(Position(centerX + 2, centerY));

    // Add legs on the lower side
    lizard.add(Position(centerX + 2, centerY - 2)); // Lower right leg
    lizard.add(Position(centerX + 2, centerY - 1)); // Lower right leg
    lizard.add(Position(centerX + 2, centerY));     // Lower right leg
    lizard.add(Position(centerX + 2, centerY + 1)); // Lower right leg
    lizard.add(Position(centerX + 2, centerY + 2)); // Lower right leg
  }

  /// Places food at a random empty location on the board
  void _placeFood() {
    while (true) {
      int x = random.nextInt(boardHeight);
      int y = random.nextInt(boardWidth);
      if (_isCellEmpty(x, y)) {
        food = Position(x, y);
        break;
      }
    }
  }

  /// Checks if a specific cell is empty (no lizard segments)
  bool _isCellEmpty(int x, int y) {
    for (var segment in lizard) {
      if (segment.x == x && segment.y == y) {
        return false;
      }
    }
    return true;
  }

  /// Draws the current state of the board
  void _drawBoard() {
    // Clear the board
    for (int i = 0; i < boardHeight; i++) {
      for (int j = 0; j < boardWidth; j++) {
        board[i][j] = emptySpace;
      }
    }

    // Draw the food
    board[food.x][food.y] = foodSymbol;

    // Draw the lizard
    for (var segment in lizard) {
      // Ensure the lizard doesn't overwrite the food symbol
      if (!(segment.x == food.x && segment.y == food.y)) {
        board[segment.x][segment.y] = lizardSymbol; // Draw body/arms/legs
      }
    }

    // Render the board
    _render();
  }

  /// Renders the board to the terminal with smooth animation
  void _render() {
    // ANSI escape code to move the cursor to the top-left corner
    stdout.write("\x1B[H");

    // Print the board
    for (var row in board) {
      print(row.join());
    }

    // Print game status
    if (isGameOver) {
      print("\nGame Over! You collided.");
      print("Press Ctrl+C to exit.");
    } else {
      print("\nPress Ctrl+C to exit.");
    }
  }

  /// Moves the lizard towards the food
  void _moveLizard() {
    if (isGameOver) return;

    Position head = lizard.first;

    // Determine the next direction towards the food
    List<int> nextStep = _calculateDirection(head, food);

    // Calculate new head position
    int newX = head.x + nextStep[0];
    int newY = head.y + nextStep[1];
    Position newHead = Position(newX, newY);

    // Check for collisions
    if (_isCollision(newHead)) {
      isGameOver = true;
      _drawBoard();
      return;
    }

    // Add new head to the front of the linked list
    lizard.addFirst(newHead);

    // Check if food is eaten
    if (newHead.equals(food)) {
      // Grow lizard: do not remove the tail
      _placeFood();
    } else {
      // Move: remove the tail
      lizard.last.unlink();
    }
  }

  /// Checks if the new head position results in a collision
  bool _isCollision(Position pos) {
    // Check wall collision
    if (pos.x < 0 || pos.x >= boardHeight || pos.y < 0 || pos.y >= boardWidth) {
      return true;
    }

    // Check self-collision
    for (var segment in lizard) {
      if (segment != lizard.last && segment.equals(pos)) {
        return true;
      }
    }

    return false;
  }

  /// Calculates the direction to move towards the target (food)
  List<int> _calculateDirection(Position head, Position target) {
    int dx = target.x - head.x;
    int dy = target.y - head.y;

    // Prioritize vertical movement if vertical distance is greater
    if (dx.abs() > dy.abs()) {
      return dx > 0 ? directions[1] : directions[0]; // down or up
    } else if (dy != 0) {
      return dy > 0 ? directions[3] : directions[2]; // right or left
    } else {
      // If already at the target, choose a random direction to avoid stalling
      return directions[random.nextInt(4)];
    }
  }

  /// Starts the game loop with frame-based animation
  void start() {
    // Clear the terminal and hide the cursor for better animation
    _clearTerminal();
    _hideCursor();

    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (isGameOver) {
        timer.cancel();
        _showCursor();
      } else {
        _moveLizard();
        _drawBoard();
      }
    });

    // Listen for Ctrl+C to gracefully exit
    ProcessSignal.sigint.watch().listen((signal) {
      _showCursor();
      exit(0);
    });
  }

  /// Clears the terminal screen
  void _clearTerminal() {
    if (Platform.isWindows) {
      // Clear screen for Windows
      stdout.write("\x1B[2J\x1B[0;0H");
    } else {
      // Clear screen for Unix-like systems
      stdout.write("\x1B[2J\x1B[0;0H");
    }
  }

  /// Hides the cursor for better animation effect
  void _hideCursor() {
    stdout.write("\x1B[?25l");
  }

  /// Shows the cursor after the game ends
  void _showCursor() {
    stdout.write("\x1B[?25h");
  }
}

void main() {
  LizardGame game = LizardGame();
  game.start();
}
