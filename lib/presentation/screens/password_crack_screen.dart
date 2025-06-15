import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wimax_pentest_tool/services/terminal_service.dart';
import 'package:wimax_pentest_tool/services/history_service.dart';

class PasswordCrackScreen extends StatefulWidget {
  const PasswordCrackScreen({super.key});

  @override
  State<PasswordCrackScreen> createState() => _PasswordCrackScreenState();
}

class _PasswordCrackScreenState extends State<PasswordCrackScreen> {
  String? capFilePath;
  String? wordlistPath;
  String result = '';
  bool loading = false;

  final TerminalService _terminalService = TerminalService();
  final HistoryService _historyService = HistoryService();

  Future<void> _pickFile(bool isCap) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        if (isCap) {
          capFilePath = result.files.single.path!;
        } else {
          wordlistPath = result.files.single.path!;
        }
      });
    }
  }

  Future<void> _startCrack() async {
    if (capFilePath == null || wordlistPath == null) return;

    setState(() {
      loading = true;
      result = "🧪 جاري تجربة كلمات المرور...";
    });

    // final toolsDir = await ToolInstaller.toolsDir; // This will be handled later
    final output = await _terminalService.runCommand(
      'aircrack-ng "$capFilePath" -w "$wordlistPath"',
    );

    setState(() {
      result = output;
      loading = false;
    });

    await _historyService.saveLog("🗝️ Brute-force:\n$output");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🗝️ كسر كلمات مرور (aircrack-ng)")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _pickFile(true),
              child: const Text("📁 اختر ملف CAP"),
            ),
            Text(capFilePath ?? "لم يتم اختيار ملف"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickFile(false),
              child: const Text("📁 اختر ملف Wordlist"),
            ),
            Text(wordlistPath ?? "لم يتم اختيار ملف"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: const Text("ابدأ التخمين"),
              onPressed: loading ? null : _startCrack,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: const TextStyle(fontFamily: "monospace", color: Colors.green),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


