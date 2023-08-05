import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

/// Wraps a list of children widget in a [Column], [SingleChildScrollView] and [Padding].
/// The padding defaults to [kYaruPagePadding]
/// but can be set if wanted.
class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.children,
    this.padding,
    this.controller,
  });

  final List<Widget> children;
  final EdgeInsets? padding;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Center(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(kYaruPagePadding),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
