import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _historyKey = 'scan_history';

  Future<void> saveLog(String logEntry) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.add(logEntry);
    await prefs.setStringList(_historyKey, history);
  }

  Future<String> readHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    return history.join('\n\n');
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}


