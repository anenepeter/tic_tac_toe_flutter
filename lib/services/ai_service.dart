import 'dart:math';
import 'game_service.dart';

class AIService {
  AIService({required GameService gameService}) : _gameService = gameService;

  final GameService _gameService;
  String _difficulty = 'easy';
  final Random _random = Random();

  void setDifficulty(String difficulty) {
    _difficulty = difficulty.toLowerCase();
  }

  String makeMove(List<List<String>> board) {
    switch (_difficulty) {
      case 'hard':
        return _hardAiMove(board);
      case 'medium':
        return _mediumAiMove(board);
      case 'easy':
      default:
        return _easyAiMove(board);
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

  String _easyAiMove(List<List<String>> board) {
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

  String _mediumAiMove(List<List<String>> board) {
    int bestScore = -1000;
    String bestMove = '';

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = _minimax(board, 0, -1000, 1000, false);
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

  String _hardAiMove(List<List<String>> board) {
    int bestScore = -1000;
    String bestMove = '';

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = _minimax(board, 0, -1000, 1000, false);
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

  int _minimax(List<List<String>> board, int depth, int alpha, int beta, bool isMaximizing) {
    // Check terminal states
    if (_gameService.checkWin(board, 'O').isNotEmpty) return 10 - depth;
    if (_gameService.checkWin(board, 'X').isNotEmpty) return depth - 10;
    if (_gameService.checkDraw(board)) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'O';
            int score = _minimax(board, depth + 1, alpha, beta, false);
            board[i][j] = '';
            bestScore = max(bestScore, score);
            alpha = max(alpha, bestScore);
            if (beta <= alpha) {
              break;
            }
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
            int score = _minimax(board, depth + 1, alpha, beta, true);
            board[i][j] = '';
            bestScore = min(bestScore, score);
            beta = min(beta, bestScore);
            if (beta < alpha) {
              break;
            }
          }
        }
      }
      return bestScore;
    }
  }
}
