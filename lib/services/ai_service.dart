import 'dart:math';

class AIService {
  String easyAiMove(List<List<String>> board) {
    List<int> emptyCells = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          emptyCells.add(i * 3 + j); // Convert 2D index to 1D
        }
      }
    }

    if (emptyCells.isEmpty) {
      return ''; // No move possible
    }

    final random = Random();
    int randomIndex = random.nextInt(emptyCells.length);
    int moveIndex = emptyCells[randomIndex];
    int row = moveIndex ~/ 3;
    int col = moveIndex % 3;
    return '$row,$col'; // Return move as "row,col" string
  }
}