import 'dart:io';

class TerminalService {
  Future<String> runCommand(String command) async {
    try {
      final result = await Process.run('bash', ['-c', command]);
      if (result.exitCode == 0) {
        return result.stdout.toString();
      } else {
        return 'Error: ${result.stderr}';
      }
    } catch (e) {
      return 'Exception: $e';
    }
  }
}


