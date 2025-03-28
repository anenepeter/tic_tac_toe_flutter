import 'package:flutter/material.dart';
import 'screens/main_menu_screen.dart';
import 'screens/game_screen.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainMenuScreen(),
      routes: {
        '/game': (context) => ChangeNotifierProvider(
          create: (context) => GameProvider(),
          child: const GameScreen(),
        ),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
