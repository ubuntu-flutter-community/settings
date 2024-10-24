import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/appearance/dock_model.dart';
import 'package:settings/view/pages/appearance/dock_section.dart';
import 'package:settings/view/pages/appearance/theme_section.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<DockModel>(
      create: (_) => DockModel(di<GSettingsService>()),
      child: const AppearancePage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.appearancePageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.appearancePageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return const SettingsPage(
      children: [
        ThemeSection(),
        DockSection(),
      ],
    );
  }
}
