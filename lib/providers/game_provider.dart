import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';

class GameProvider extends ChangeNotifier {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, '')); // 3x3 board
  final GameService _gameService = GameService();
  String _currentPlayer = 'X'; // X starts first
  String _gameStatus = 'Player X\'s turn';
  int _playerXScore = 0;
  int _playerOScore = 0;

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get gameStatus => _gameStatus;
  int get playerXScore => _playerXScore;
  int get playerOScore => _playerOScore;

  void makeMove(int row, int col) {
    if (_gameService.validateMove(_board, row, col)) {
      _board[row][col] = _currentPlayer;
      if (_gameService.checkWin(_board, _currentPlayer)) {
        _gameStatus = 'Player $_currentPlayer wins!';
        if (_currentPlayer == 'X') {
          _playerXScore++;
        } else {
          _playerOScore++;
        }
      } else if (_gameService.checkDraw(_board)) {
        _gameStatus = 'Draw!';
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X'; // Switch player turn
        _gameStatus = 'Player $_currentPlayer\'s turn';
      }
      notifyListeners(); // Notify listeners after state change
    } else {
      print('Invalid move'); // TODO: Handle invalid move, show error message?
    }
  }
}