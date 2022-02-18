import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/appearance/dock_model.dart';
import 'package:settings/view/pages/appearance/dark_mode_section.dart';
import 'package:settings/view/pages/appearance/dock_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<DockModel>(
      create: (_) => DockModel(service),
      child: const AppearancePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const YaruPage(
      children: [
        DarkModeSection(),
        DockSection(),
      ],
    );
  }
}
