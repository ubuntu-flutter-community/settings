import 'package:flutter/material.dart';

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0);
}
