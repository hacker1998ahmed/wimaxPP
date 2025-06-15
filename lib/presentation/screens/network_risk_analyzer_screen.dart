import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class NetworkRiskAnalyzerScreen extends StatefulWidget {
  const NetworkRiskAnalyzerScreen({super.key});

  @override
  State<NetworkRiskAnalyzerScreen> createState() => _NetworkRiskAnalyzerScreenState();
}

class _NetworkRiskAnalyzerScreenState extends State<NetworkRiskAnalyzerScreen> {
  List<WifiNetwork> networks = [];

  @override
  void initState() {
    super.initState();
    _loadNetworks();
  }

  Future<void> _loadNetworks() async {
    final list = await WiFiForIoTPlugin.loadWifiList();
    setState(() {
      networks = list ?? [];
    });
  }

  String _analyzeRisk(WifiNetwork wifi) {
    final caps = wifi.capabilities?.toUpperCase() ?? '';
    bool isOpen = caps.contains('ESS') && !caps.contains('WPA') && !caps.contains('WEP');
    bool isWEP = caps.contains('WEP');
    bool isWPS = caps.contains('WPS');
    int level = wifi.level ?? -100;

    if (isOpen || isWEP) return '🔥 خطير جداً';
    if (isWPS || level > -50) return '⚠️ متوسط الخطر';
    return '✅ آمن نسبياً';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🔍 تحليل أمان الشبكات")),
      body: ListView.builder(
        itemCount: networks.length,
        itemBuilder: (context, index) {
          final wifi = networks[index];
          final risk = _analyzeRisk(wifi);
          return Card(
            margin: const EdgeInsets.all(6),
            child: ListTile(
              leading: const Icon(Icons.wifi),
              title: Text(wifi.ssid ?? "شبكة غير معروفة"),
              subtitle: Text("BSSID: ${wifi.bssid ?? "?"}\nالإشارة: ${wifi.level}\nنوع التشفير: ${wifi.capabilities}"),
              trailing: Text(risk, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}


