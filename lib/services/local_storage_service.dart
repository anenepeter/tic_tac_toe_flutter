import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _playerXScoreKey = 'playerXScore';
  static const String _playerOScoreKey = 'playerOScore';

  Future<void> saveScores(int playerXScore, int playerOScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_playerXScoreKey, playerXScore);
    await prefs.setInt(_playerOScoreKey, playerOScore);
  }

  Future<Map<String, int>> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    int playerXScore = prefs.getInt(_playerXScoreKey) ?? 0;
    int playerOScore = prefs.getInt(_playerOScoreKey) ?? 0;
    return {'playerXScore': playerXScore, 'playerOScore': playerOScore};
  }

  Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_playerXScoreKey);
    await prefs.remove(_playerOScoreKey);
  }
}