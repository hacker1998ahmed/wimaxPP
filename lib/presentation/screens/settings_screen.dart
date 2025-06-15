import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("⚙️ الإعدادات")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("الوضع الليلي"),
            value: _darkMode,
            onChanged: (val) {
              setState(() {
                _darkMode = val;
                _saveSettings();
              });
            },
          ),
          const ListTile(
            title: Text("اللغة"),
            subtitle: Text("العربية (افتراضية)"),
            trailing: Icon(Icons.language),
          ),
          const ListTile(
            title: Text("حول التطبيق"),
            subtitle: Text("WiMAX Security\n© 2025 Ahmed Hacker"),
            trailing: Icon(Icons.info),
          )
        ],
      ),
    );
  }
}
