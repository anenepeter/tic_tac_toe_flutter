import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/game_board.dart';
import '../providers/game_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Consumer<GameProvider>(
                  builder: (context, gameProvider, _) => AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: gameProvider.currentPlayer == 'X' ? FontWeight.bold : FontWeight.normal,
                      color: gameProvider.currentPlayer == 'X' ? Colors.blue : Colors.black,
                    ),
                    child: Text('Player X: ${gameProvider.playerXScore}'),
                  ),
                ),// Placeholder for Player X score
                Consumer<GameProvider>(
                  builder: (context, gameProvider, _) => AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: gameProvider.currentPlayer == 'O' ? FontWeight.bold : FontWeight.normal,
                      color: gameProvider.currentPlayer == 'O' ? Colors.red : Colors.black,
                    ),
                    child: Text('Player O: ${gameProvider.playerOScore}'),
                  ),
                ),// Placeholder for Player O score
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                child: Consumer<GameProvider>(
                  builder: (context, gameProvider, _) => GameBoard(),
                ), // GameBoard widget now wrapped with Consumer and Padding
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<GameProvider>(
              builder: (context, gameProvider, _) => ElevatedButton(
                onPressed: () {
                  gameProvider.resetGame();
                },
                child: const Text('Reset Game'),
              ),
            ),
          ),
          Consumer<GameProvider>(
            builder: (context, gameProvider, _) => Text('Game Status: ${gameProvider.gameStatus}'), // Placeholder for game status message
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}