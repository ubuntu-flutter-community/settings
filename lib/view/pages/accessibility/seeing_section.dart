import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class SeeingSection extends StatelessWidget {
  const SeeingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Seeing',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Screen Reader',
          actionDescription:
              'The screen reader reads displayed text as you move the focus',
          value: _model.getScreenReader,
          onChanged: (value) => _model.setScreenReader(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Sound Keys',
          actionDescription:
              'Beep when Num Lock or Caps Lock are turned on or off',
          value: _model.getToggleKeys,
          onChanged: (value) => _model.setToggleKeys(value),
        ),
      ],
    );
  }
}
