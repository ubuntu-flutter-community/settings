import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/accessibility/global_section.dart';
import 'package:settings/view/pages/accessibility/hearing_section.dart';
import 'package:settings/view/pages/accessibility/pointing_and_clicking_section.dart';
import 'package:settings/view/pages/accessibility/seeing_section.dart';
import 'package:settings/view/pages/accessibility/typing_section.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<AccessibilityModel>(
      create: (_) => AccessibilityModel(di<GSettingsService>()),
      child: const AccessibilityPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.accessibilityPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.accessibilityPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return const SettingsPage(
      children: [
        GlobalSection(),
        SeeingSection(),
        HearingSection(),
        TypingSection(),
        PointingAndClickingSection(),
      ],
    );
  }
}
