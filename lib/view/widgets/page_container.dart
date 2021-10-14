import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
          width:
              516, // 500 width + 8 padding on each edges (for SettingsSection)
          child: child),
    );
  }
}
