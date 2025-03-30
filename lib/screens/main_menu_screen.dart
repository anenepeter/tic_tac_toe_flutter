import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    gameProvider.setGameMode('single_player');
                    gameProvider.resetGame();
                    Navigator.pushNamed(context, '/game');
                  },
                  child: const Text('Single Player'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    gameProvider.setGameMode('two_player');
                    gameProvider.resetGame();
                    Navigator.pushNamed(context, '/game');
                  },
                  child: const Text('Two Player'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: const Text('Settings'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: const Text('About'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}