import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:settings/view/pages/chose_your_look_page.dart';
import 'package:settings/view/pages/dock_page.dart';
import 'package:settings/view/widgets/app_theme.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ChoseYourLookPage(theme: theme),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: DockPage(),
            )
          ],
        ),
      ),
    );
  }
}
