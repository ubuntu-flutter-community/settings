import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class GlobalSection extends StatelessWidget {
  const GlobalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Global',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Always Show Universal Access Menu',
          value: model.getUniversalAccessStatus,
          onChanged: (value) => model.setUniversalAccessStatus(value),
        ),
      ],
    );
  }
}
