import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';

class GlobalSection extends StatelessWidget {
  const GlobalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.global),
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.alwaysShowUniversalAccessMenu),
          value: model.universalAccessStatus,
          onChanged: model.setUniversalAccessStatus,
        ),
      ],
    );
  }
}
