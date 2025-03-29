import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/ai_service.dart';
import 'dart:math';

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
  String _aiDifficulty = 'easy';

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get gameStatus => _gameStatus;
  int get playerXScore => _playerXScore;
  int get playerOScore => _playerOScore;
  bool get isGameOver => _isGameOver;
  String get gameMode => _gameMode;
  String get aiDifficulty => _aiDifficulty;

  void makeMove(int row, int col) {
    if (_isGameOver || !_gameService.validateMove(_board, row, col)) return;

    // Make player move
    _board[row][col] = _currentPlayer;
    
    // Check game state after player move
    if (_gameService.checkWin(_board, _currentPlayer)) {
      _gameStatus = 'Player $_currentPlayer wins!';
      _isGameOver = true;
      if (_currentPlayer == 'X') {
        _playerXScore++;
      } else {
        _playerOScore++;
      }
      notifyListeners();
      return;
    }
    
    if (_gameService.checkDraw(_board)) {
      _gameStatus = 'Draw!';
      _isGameOver = true;
      notifyListeners();
      return;
    }

    // Switch player
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    _gameStatus = 'Player $_currentPlayer\'s turn';
    notifyListeners();

    // Make AI move if it's single player mode and O's turn
    if (_gameMode == 'single_player' && _currentPlayer == 'O') {
      _makeAIMove();
    }
  }

  void _makeAIMove() {
    if (_isGameOver) return;
    
    Future.delayed(const Duration(milliseconds: 500), () {
      String aiMove = _aiService.makeMove(_board);
      if (aiMove.isNotEmpty) {
        List<String> moveCoords = aiMove.split(',');
        int row = int.parse(moveCoords[0]);
        int col = int.parse(moveCoords[1]);
        
        _board[row][col] = _currentPlayer;
        
        if (_gameService.checkWin(_board, _currentPlayer)) {
          _gameStatus = 'AI wins!';
          _isGameOver = true;
          _playerOScore++;
        } else if (_gameService.checkDraw(_board)) {
          _gameStatus = 'Draw!';
          _isGameOver = true;
        } else {
          _currentPlayer = 'X';
          _gameStatus = 'Your turn';
        }
        notifyListeners();
      }
    });
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _gameStatus = 'Player X\'s turn';
    _isGameOver = false; // Reset game over state
    notifyListeners();
  }

  void setGameMode(String mode) {
    _gameMode = mode;
    notifyListeners();
  }

  void startSinglePlayerGame() {
    _gameMode = 'single_player';
    resetGame();
    // Randomly decide who starts
    if (Random().nextBool()) {
      _currentPlayer = 'O';
      _gameStatus = 'AI\'s turn';
      _makeAIMove();
    }
    notifyListeners();
  }

  void setAIDifficulty(String difficulty) {
    _aiDifficulty = difficulty;
    _aiService.setDifficulty(difficulty);
    notifyListeners();
  }

  void resetScores() {
    _playerXScore = 0;
    _playerOScore = 0;
    notifyListeners();
  }
}