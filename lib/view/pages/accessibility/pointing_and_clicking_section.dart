import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Pointing & Clicking',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Mouse Keys',
          value: _model.getMouseKeys,
          onChanged: (value) => _model.setMouseKeys(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Locate Pointer',
          value: _model.getLocatePointer,
          onChanged: (value) => _model.setLocatePointer(value),
        ),
        SettingsRow(
          actionLabel: 'Double-Click Delay',
          secondChild: Expanded(
            child: Slider(
              min: 100,
              max: 1000,
              value: _model.getDoubleClickDelay,
              onChanged: (double value) {
                _model.setDoubleClickDelay(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
