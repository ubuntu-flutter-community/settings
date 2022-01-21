import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/power/battery_section.dart';
import 'package:settings/view/pages/power/power_profile_section.dart';
import 'package:settings/view/pages/power/power_settings_section.dart';
import 'package:settings/view/pages/power/suspend_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PowerPage extends StatelessWidget {
  const PowerPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const PowerPage();

  @override
  Widget build(BuildContext context) {
    return YaruPage(
      children: <Widget>[
        BatterySection.create(context),
        PowerProfileSection.create(context),
        PowerSettingsSection.create(context),
        SuspendSection.create(context),
      ],
    );
  }
}
