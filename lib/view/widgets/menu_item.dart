import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItem {
  final String name;
  final IconData iconData;
  final Widget details;

  const MenuItem(
      {required this.name, required this.iconData, required this.details});
}
