import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/settings_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Widget create(BuildContext context) => const SearchPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.searchPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.searchPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      children: [Center(child: Text(context.l10n.searchPageTitle))],
    );
  }
}
