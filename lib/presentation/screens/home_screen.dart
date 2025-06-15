import 'package:flutter/material.dart';
import 'live_bruteforce_screen.dart';
import 'wps_attack_screen.dart';
import 'handshake_capture_screen.dart';
import 'network_risk_analyzer_screen.dart';
import 'password_crack_screen.dart';
import 'history_screen.dart';
import 'device_info_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🔐 WiMAX Security App")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("اختر أداة الفحص أو الهجوم:", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              _buildButton(context, "🔓 تخمين مباشر", const LiveBruteForceScreen()),
              _buildButton(context, "🔐 هجوم WPS", const WpsAttackScreen()),
              _buildButton(context, "📶 التقاط Handshake", const HandshakeCaptureScreen()),
              _buildButton(context, "🧠 تحليل أمان الشبكات", const NetworkRiskAnalyzerScreen()),
              _buildButton(context, "🗝️ كسر كلمات مرور CAP", const PasswordCrackScreen()),
              _buildButton(context, "📄 سجل الفحوصات", const HistoryScreen()),
              _buildButton(context, "ℹ️ معلومات الجهاز", const DeviceInfoScreen()),
              _buildButton(context, "⚙️ الإعدادات", const SettingsScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        ),
        child: Text(label),
      ),
    );
  }
}
