import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/appearance/appearance_model.dart';
import 'package:settings/view/pages/appearance/chose_your_look_section.dart';
import 'package:settings/view/pages/appearance/dock_section.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<AppearanceModel>(
      create: (_) => AppearanceModel(service),
      child: const AppearancePage(),
    );
  }

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
