import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:settings/view/pages/appearance/chose_your_look_section.dart';
import 'package:settings/view/pages/appearance/dock_section.dart';
import 'package:settings/view/widgets/app_theme.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [ChoseYourLookSection(theme: theme), const DockSection()],
        ),
      ),
    );
  }
}
