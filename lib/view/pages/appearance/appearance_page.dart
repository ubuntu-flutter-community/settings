import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
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

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.appearancePageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.appsPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

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
