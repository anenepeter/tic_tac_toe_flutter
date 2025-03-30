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
        // 70% chance of making a strategic move, 30% chance of random move
        return _random.nextDouble() < 0.7 ? _mediumAiMove(board) : _easyAiMove(board);
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
    return _getRandomMove(board);
  }

  String _mediumAiMove(List<List<String>> board) {
    // First try to win
    String winningMove = _findWinningMove(board, 'O');
    if (winningMove.isNotEmpty) return winningMove;

    // Then try to block player
    String blockingMove = _findWinningMove(board, 'X');
    if (blockingMove.isNotEmpty) return blockingMove;

    // If no winning or blocking moves, try to take center or corners
    if (board[1][1].isEmpty) return '1,1';
    
    // Try corners
    const List<String> corners = ['0,0', '0,2', '2,0', '2,2'];
    List<String> shuffledCorners = List.from(corners);
    shuffledCorners.shuffle(_random);
    for (String corner in shuffledCorners) {
      List<String> coords = corner.split(',');
      int row = int.parse(coords[0]);
      int col = int.parse(coords[1]);
      if (board[row][col].isEmpty) return corner;
    }

    // Otherwise make a random move
    return _getRandomMove(board);
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

  String _findWinningMove(List<List<String>> board, String player) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = player;
          if (_gameService.checkWin(board, player).isNotEmpty) {
            board[i][j] = '';
            return '$i,$j';
          }
          board[i][j] = '';
        }
      }
    }
    return '';
  }
}
