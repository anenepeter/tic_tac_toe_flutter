import 'dart:math';

class AIService {
  String _difficulty = 'easy';
  final Random _random = Random();

  void setDifficulty(String difficulty) {
    _difficulty = difficulty.toLowerCase();
  }

  String makeMove(List<List<String>> board) {
    switch (_difficulty) {
      case 'hard':
        return _getBestMove(board);
      case 'medium':
        return _random.nextBool() ? _getBestMove(board) : _getRandomMove(board);
      case 'easy':
      default:
        return _getRandomMove(board);
    }
  }

  String _getRandomMove(List<List<String>> board) {
    List<String> availableMoves = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          availableMoves.add('$i,$j');
        }
      }
    }
    if (availableMoves.isEmpty) return '';
    return availableMoves[_random.nextInt(availableMoves.length)];
  }

  String _getBestMove(List<List<String>> board) {
    int bestScore = -1000;
    String bestMove = '';

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = _minimax(board, 0, false);
          board[i][j] = '';

          if (score > bestScore) {
            bestScore = score;
            bestMove = '$i,$j';
          }
        }
      }
    }
    return bestMove;
  }

  int _minimax(List<List<String>> board, int depth, bool isMaximizing) {
    // Check terminal states
    if (_checkWin(board, 'O')) return 10 - depth;
    if (_checkWin(board, 'X')) return depth - 10;
    if (_checkDraw(board)) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'O';
            bestScore = max(bestScore, _minimax(board, depth + 1, false));
            board[i][j] = '';
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'X';
            bestScore = min(bestScore, _minimax(board, depth + 1, true));
            board[i][j] = '';
          }
        }
      }
      return bestScore;
    }
  }

  bool _checkWin(List<List<String>> board, String player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
    }
    // Check columns
    for (int j = 0; j < 3; j++) {
      if (board[0][j] == player && board[1][j] == player && board[2][j] == player) {
        return true;
      }
    }
    // Check diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;
    return false;
  }

  bool _checkDraw(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) return false;
      }
    }
    return true;
  }
}