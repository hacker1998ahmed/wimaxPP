import 'package:flutter/material.dart';
import 'package:wimax_pentest_tool/services/terminal_service.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String _deviceInfo = 'جاري جمع معلومات الجهاز...';

  final TerminalService _terminalService = TerminalService();

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    // This is a placeholder. In a real app, you would use platform-specific code
    // or packages like 'device_info_plus' to get actual device information.
    // For now, we'll simulate some output from a terminal command.
    final output = await _terminalService.runCommand('uname -a');
    setState(() {
      _deviceInfo = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📱 معلومات الجهاز")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Text(
            _deviceInfo,
            style: const TextStyle(fontFamily: "monospace", color: Colors.green),
          ),
        ),
      ),
    );
  }
}


