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
                  builder: (context, gameProvider, _) => Text('Player X: ${gameProvider.playerXScore}'),
                ),// Placeholder for Player X score
                Consumer<GameProvider>(
                  builder: (context, gameProvider, _) => Text('Player O: ${gameProvider.playerOScore}'),
                ),// Placeholder for Player O score
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Consumer<GameProvider>(
                builder: (context, gameProvider, _) => GameBoard(),
              ), // GameBoard widget now wrapped with Consumer
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement reset game functionality
                print('Reset Game button pressed');
              },
              child: const Text('Reset Game'),
            ),
          ),
          Text('Game Status: Player X\'s turn'), // Placeholder for game status message
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}