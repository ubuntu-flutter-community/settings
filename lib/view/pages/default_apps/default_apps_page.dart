import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DefaultAppsPage extends StatelessWidget {
  const DefaultAppsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const DefaultAppsPage();

  static Widget createTitle(BuildContext context) =>
      YaruPageItemTitle.text(context.l10n.defaultAppsPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.defaultAppsPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      children: [
        Center(
          child: Text(context.l10n.defaultAppsPageTitle),
        )
      ],
    );
  }
}
