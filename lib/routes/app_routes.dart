import 'package:flutter/material.dart';
import '../presentation/main_dashboard/main_dashboard.dart';
import '../presentation/attack_modules/attack_modules.dart';
import '../presentation/password_cracking/password_cracking.dart';
import '../presentation/screens/device_info_screen.dart';
import '../presentation/screens/handshake_capture_screen.dart';
import '../presentation/screens/history_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/live_bruteforce_screen.dart';
import '../presentation/screens/network_risk_analyzer_screen.dart';
import '../presentation/screens/password_crack_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/wps_attack_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String mainDashboard = '/main-dashboard';
  static const String attackModules = '/attack-modules';
  static const String passwordCracking = '/password-cracking';
  static const String homeScreen = '/home-screen';
  static const String liveBruteForceScreen = '/live-bruteforce-screen';
  static const String wpsAttackScreen = '/wps-attack-screen';
  static const String handshakeCaptureScreen = '/handshake-capture-screen';
  static const String networkRiskAnalyzerScreen = '/network-risk-analyzer-screen';
  static const String passwordCrackScreen = '/password-crack-screen';
  static const String historyScreen = '/history-screen';
  static const String deviceInfoScreen = '/device-info-screen';
  static const String settingsScreen = '/settings-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeScreen(),
    mainDashboard: (context) => const MainDashboard(),
    attackModules: (context) => const AttackModules(),
    passwordCracking: (context) => const PasswordCracking(),
    homeScreen: (context) => const HomeScreen(),
    liveBruteForceScreen: (context) => const LiveBruteForceScreen(),
    wpsAttackScreen: (context) => const WpsAttackScreen(),
    handshakeCaptureScreen: (context) => const HandshakeCaptureScreen(),
    networkRiskAnalyzerScreen: (context) => const NetworkRiskAnalyzerScreen(),
    passwordCrackScreen: (context) => const PasswordCrackScreen(),
    historyScreen: (context) => const HistoryScreen(),
    deviceInfoScreen: (context) => const DeviceInfoScreen(),
    settingsScreen: (context) => const SettingsScreen(),
  };
}


