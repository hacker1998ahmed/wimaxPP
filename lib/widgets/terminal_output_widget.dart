import 'package:flutter/material.dart';

class TerminalOutputWidget extends StatelessWidget {
  final String output;

  const TerminalOutputWidget({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: SelectableText(
        output.isEmpty ? "لا توجد مخرجات بعد." : output,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: "monospace",
          fontSize: 14,
        ),
      ),
    );
  }
}
