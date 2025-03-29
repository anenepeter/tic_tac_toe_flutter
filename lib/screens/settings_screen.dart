import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Difficulty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: gameProvider.aiDifficulty,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'easy',
                      child: Text('Easy'),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: 'hard',
                      child: Text('Hard'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      gameProvider.setAIDifficulty(newValue);
                    }
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    gameProvider.resetScores();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Scores have been reset')),
                    );
                  },
                  child: const Text('Reset Scores'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}