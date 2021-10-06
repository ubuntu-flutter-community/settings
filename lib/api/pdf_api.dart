import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateSystemData(
    String osName,
    String osVersion,
    String processorName,
    String processorCount,
    String memory,
    String graphics,
    String diskCapacity,
    String osType,
    String gnomeVersion,
    String windowServer,
  ) async {
    final pdf = Document();
    final imageCOF = (await rootBundle.load('assets/pdf_assets/cof.png'))
        .buffer
        .asUint8List();
    pdf.addPage(Page(
      build: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(
                child: Image(MemoryImage(imageCOF)), height: 48, width: 48),
            Text("$osName $osVersion",
                style: const TextStyle(
                  fontSize: 32,
                )),
          ], mainAxisAlignment: MainAxisAlignment.center),
          SizedBox(height: 20),
          Divider(),
          Text("Hardware", style: const TextStyle(fontSize: 20)),
          Divider(),
          Text("OS Name: $osName"),
          Text("OS Version: $osVersion"),
          Text("Processor: $processorName x$processorCount"),
          Text("Memory: $memory Gb"),
          Text("Graphics: $graphics"),
          Text("Disk Capacity: $diskCapacity"),
          SizedBox(height: 20),
          Divider(),
          Text("System", style: const TextStyle(fontSize: 20)),
          Divider(),
          Text("OS Name: $osName $osVersion"),
          Text("Os Type: $osType-bit"),
          Text("GNOME version: $gnomeVersion"),
          Text("Windowing System: $windowServer"),
        ],
      ),
    ));

    return saveDocument(name: "System Data.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);

    return file;
  }
}
