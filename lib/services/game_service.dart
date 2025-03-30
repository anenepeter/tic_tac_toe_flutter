class GameService {
  static const List<List<String>> initialBoard = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  List<List<String>> initializeBoard() {
    return initialBoard;
  }

  List<int> checkWin(List<List<String>> board, String player) {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return [i * 3 + 0, i * 3 + 1, i * 3 + 2]; // row
      }
      if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
        return [0 * 3 + i, 1 * 3 + i, 2 * 3 + i]; // col
      }
    }
    // Check diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
      return [0, 4, 8];
    }
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
      return [2, 4, 6];
    }
    return [];
  }

  bool checkDraw(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false; // If any cell is empty, it's not a draw
        }
      }
    }
    return checkWin(board, 'X').isEmpty && checkWin(board, 'O').isEmpty; // It's a draw if no winner and board is full
  }

  bool validateMove(List<List<String>> board, int row, int col) {
    // Check if the cell is already occupied
    if (board[row][col].isNotEmpty) {
      return false; // Cell is occupied, move is invalid
    }
    return true; // Cell is empty, move is valid
  }
}