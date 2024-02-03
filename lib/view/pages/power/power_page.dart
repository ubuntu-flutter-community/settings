import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/power/battery_section.dart';
import 'package:settings/view/pages/power/lid_close_section.dart';
import 'package:settings/view/pages/power/power_profile_section.dart';
import 'package:settings/view/pages/power/power_settings_section.dart';
import 'package:settings/view/pages/power/suspend_section.dart';
import 'package:settings/view/pages/settings_page.dart';

class PowerPage extends StatelessWidget {
  const PowerPage({super.key});

  static Widget create(BuildContext context) => const PowerPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.powerPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.powerPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      children: <Widget>[
        BatterySection.create(context),
        PowerProfileSection.create(context),
        PowerSettingsSection.create(context),
        SuspendSection.create(context),
        LidCloseSection.create(context),
      ],
    );
  }
}
