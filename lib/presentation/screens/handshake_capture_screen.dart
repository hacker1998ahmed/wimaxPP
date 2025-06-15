import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wimax_pentest_tool/services/terminal_service.dart';
import 'package:wimax_pentest_tool/services/tool_installer.dart';
import 'package:wimax_pentest_tool/services/history_service.dart';

class HandshakeCaptureScreen extends StatefulWidget {
  const HandshakeCaptureScreen({super.key});

  @override
  State<HandshakeCaptureScreen> createState() => _HandshakeCaptureScreenState();
}

class _HandshakeCaptureScreenState extends State<HandshakeCaptureScreen> {
  List<WifiNetwork> networks = [];
  String result = '';
  bool loading = false;
  String selectedBSSID = '';
  final channelController = TextEditingController();

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

  Future<void> _startCapture() async {
    if (selectedBSSID.isEmpty || channelController.text.isEmpty) return;

    setState(() {
      loading = true;
      result = "📡 بدء التقاط Handshake من $selectedBSSID...";
    });

    final toolsDir = await ToolInstaller.toolsDir;
    final cmd =
        '$toolsDir/airodump-ng --bssid $selectedBSSID -c ${channelController.text} -w /sdcard/handshake wlan0';

    final output = await _terminalService.runCommand(cmd);

    setState(() {
      result = output;
      loading = false;
    });

    await _historyService.saveLog("📶 Handshake Capture ($selectedBSSID):\n$output");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📶 التقاط Handshake")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: networks.length,
              itemBuilder: (context, index) {
                final wifi = networks[index];
                return ListTile(
                  title: Text(wifi.ssid ?? "غير معروفة"),
                  subtitle: Text("BSSID: ${wifi.bssid ?? "؟"}"),
                  trailing: ElevatedButton(
                    onPressed: loading || wifi.bssid == null
                        ? null
                        : () {
                            setState(() {
                              selectedBSSID = wifi.bssid!;
                            });
                          },
                    child: const Text("اختر"),
                  ),
                );
              },
            ),
          ),
          if (selectedBSSID.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("✅ الشبكة المختارة: $selectedBSSID"),
                  TextField(
                    controller: channelController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "أدخل رقم القناة (Channel)",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.network_wifi),
                    label: const Text("ابدأ الالتقاط"),
                    onPressed: loading ? null : _startCapture,
                  )
                ],
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


