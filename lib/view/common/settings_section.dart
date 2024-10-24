import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    this.width,
    this.headline,
    this.headerWidget,
    required this.children,
  });

  final double? width;
  final Widget? headline;
  final Widget? headerWidget;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return YaruSection(
      width: width,
      margin: const EdgeInsets.only(bottom: 20),
      headline: headline != null || headerWidget != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (headline != null) headline!,
                if (headerWidget != null) headerWidget!,
              ],
            )
          : null,
      child: Column(children: children),
    );
  }
}
