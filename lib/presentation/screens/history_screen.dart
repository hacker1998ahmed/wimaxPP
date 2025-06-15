import 'package:flutter/material.dart';
import 'package:wimax_pentest_tool/services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _log = '';

  final HistoryService _historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final log = await _historyService.readHistory();
    setState(() {
      _log = log;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📄 سجل الفحوصات")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Text(
            _log.isEmpty ? "لا يوجد سجل حتى الآن." : _log,
            style: const TextStyle(fontFamily: "monospace", color: Colors.green),
          ),
        ),
      ),
    );
  }
}


