import 'package:flutter/material.dart';
import 'package:settings/view/pages/appearance/chose_your_look_section.dart';
import 'package:settings/view/pages/appearance/dock_section.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ChoseYourLookSection(),
        DockSection(),
      ],
    );
  }
}
