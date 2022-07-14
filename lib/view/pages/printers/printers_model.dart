import 'dart:convert';
import 'dart:io';

import 'package:safe_change_notifier/safe_change_notifier.dart';

class PrintersModel extends SafeChangeNotifier {
  void openPrinterSettings() {
    Process.run('system-config-printer', ['&']);
  }

  Future<List<String>> loadPrinters() async {
    final List<String> printerNames = [];
    await Process.run('lpinfo', ['-v']).then((value) {
      printerNames.addAll(const LineSplitter().convert(value.stdout));
      printerNames.retainWhere((element) =>
          element.contains('network dnssd://') ||
          element.contains('network ipps://'));
    });
    return printerNames;
  }
}
