import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/ai_service.dart';

class GameProvider extends ChangeNotifier {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, '')); // 3x3 board
  final GameService _gameService = GameService();
  final AIService _aiService = AIService();
  String _currentPlayer = 'X'; // X starts first
  String _gameStatus = 'Player X\'s turn';
  int _playerXScore = 0;
  int _playerOScore = 0;
  bool _isGameOver = false;
  String _gameMode = 'two_player'; // Default game mode is two player

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get gameStatus => _gameStatus;
  int get playerXScore => _playerXScore;
  int get playerOScore => _playerOScore;
  bool get isGameOver => _isGameOver;
  String get gameMode => _gameMode;

  void makeMove(int row, int col) {
    if (_isGameOver) return; // Prevent moves if game is over

    if (_gameService.validateMove(_board, row, col)) {
      _board[row][col] = _currentPlayer;
      if (_gameService.checkWin(_board, _currentPlayer)) {
        _gameStatus = 'Player $_currentPlayer wins!';
        _isGameOver = true;
        if (_currentPlayer == 'X') {
          _playerXScore++;
        } else {
          _playerOScore++;
        }
      } else if (_gameService.checkDraw(_board)) {
        _gameStatus = 'Draw!';
        _isGameOver = true;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X'; // Switch player turn
        _gameStatus = 'Player $_currentPlayer\'s turn';
      }
      notifyListeners(); // Notify listeners after state change

      if (!_isGameOver && _gameMode == 'single_player' && _currentPlayer == 'O') {
        // AI move after player move in single player mode
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!_isGameOver) {
            String aiMove = _aiService.easyAiMove(_board);
            if (aiMove.isNotEmpty) {
              List<String> moveCoords = aiMove.split(',');
              int row = int.parse(moveCoords[0]);
              int col = int.parse(moveCoords[1]);
              makeMove(row, col); // Recursively call makeMove for AI move
            }
          }
        });
      }
    } else {
      print('Invalid move'); // TODO: Handle invalid move, show error message?
    }
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _gameStatus = 'Player X\'s turn';
    _isGameOver = false; // Reset game over state
    notifyListeners();
  }
}