import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/local_storage_service.dart'; // Import LocalStorageService
import '../services/ai_service.dart';
import 'dart:math';

class GameProvider extends ChangeNotifier {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, '')); // 3x3 board
  final GameService _gameService = GameService();
  late final AIService _aiService;
  final LocalStorageService _localStorageService = LocalStorageService(); // Initialize LocalStorageService
  String _currentPlayer = 'X'; // X starts first
  String _gameStatus = 'Player X\'s turn';
  int _playerXScore = 0;
  int _playerOScore = 0;
  bool _isGameOver = false;
  String _gameMode = 'two_player'; // Default game mode is two player
  String _aiDifficulty = 'easy';
  List<int> _winningLine = []; // To store winning line indices

  GameProvider() {
    _aiService = AIService(gameService: _gameService);
    _loadScores(); // Load scores from local storage on initialization
  }

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  List<int> get winningLine => _winningLine; // Getter for winningLine
  String get gameStatus => _gameStatus;
  int get playerXScore => _playerXScore;
  int get playerOScore => _playerOScore;
  bool get isGameOver => _isGameOver;
  String get gameMode => _gameMode;
  String get aiDifficulty => _aiDifficulty;

  Future<void> _loadScores() async {
    final scores = await _localStorageService.loadScores();
    _playerXScore = scores['playerXScore'] ?? 0;
    _playerOScore = scores['playerOScore'] ?? 0;
    notifyListeners();
  }

  void makeMove(int row, int col) {
    if (_isGameOver || !_gameService.validateMove(_board, row, col)) return;
    if (_gameMode == 'single_player' && _currentPlayer == 'O') return; // Prevent user from playing before AI

    // Make player move
    _board[row][col] = _currentPlayer;
    
    // Check game state after player move
    List<int> winningCells = _gameService.checkWin(_board, _currentPlayer);
    if (winningCells.isNotEmpty) {
      _gameStatus = 'Player $_currentPlayer wins!';
      _isGameOver = true;
      _winningLine = winningCells; // Store winning cells
      if (_currentPlayer == 'X') {
        _playerXScore++;
      } else {
        _playerOScore++;
      }
      _saveScores(); // Save scores to local storage
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
        
        List<int> winningCells = _gameService.checkWin(_board, _currentPlayer);
        if (winningCells.isNotEmpty) {
          _gameStatus = 'AI wins!';
          _isGameOver = true;
          _winningLine = winningCells; // Store winning cells
          _playerOScore++;
        } else if (_gameService.checkDraw(_board)) {
          _gameStatus = 'Draw!';
          _isGameOver = true;
        } else {
          _currentPlayer = 'X';
          _gameStatus = 'Your turn';
        }
        _saveScores(); // Save scores to local storage
        notifyListeners();
      }
    });
  }

  Future<void> _saveScores() async {
    await _localStorageService.saveScores(_playerXScore, _playerOScore);
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _gameStatus = 'Player X\'s turn';
    _isGameOver = false; // Reset game over state
    _winningLine = []; // Clear winning line
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
    _localStorageService.resetScores(); // Reset persistent scores
    notifyListeners();
  }
}