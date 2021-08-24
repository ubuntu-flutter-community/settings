import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItem {
  const MenuItem({
    required this.name,
    required this.iconData,
    required this.details,
  });

  final String name;
  final IconData iconData;
  final Widget details;
}
