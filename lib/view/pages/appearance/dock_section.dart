import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/appearance/appearance_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/slider_settings_row.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';
import 'package:settings/view/widgets/toggle_buttons_setting_row.dart';

class DockSection extends StatelessWidget {
  const DockSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AppearanceModel>(context);

    return SettingsSection(
      headline: 'Dock',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Show Trash',
          value: _model.getShowTrash,
          onChanged: (value) => _model.setShowTrash(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Always Show Dock',
          value: _model.getAlwaysShowDock,
          onChanged: (value) => _model.setAlwaysShowDock(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Extend Dock',
          value: _model.getExtendDock,
          onChanged: (value) => _model.setExtendDock(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Active App Glow',
          value: _model.getAppGlow,
          onChanged: (value) => _model.setAppGlow(value),
        ),
        SliderSettingsRow(
          actionLabel: 'Icon Size',
          value: _model.getMaxIconSize,
          min: 16,
          max: 64,
          onChanged: (value) => _model.setMaxIconSize(value),
        ),
        // SliderGsettingRow(
        ToggleButtonsSettingRow(
          actionLabel: 'Dock Position',
          currentValue: _model.getDockCurrentPosition,
          labels: const ['Left', 'Right', 'Bottom'],
          onPressed: (index) => _model.setDockPosition(index),
        ),
        ToggleButtonsSettingRow(
          actionLabel: 'App Icon Click Behaviour',
          currentValue: _model.getCurrentClickAction,
          labels: const ['Minimize', 'Focus or previews'],
          onPressed: (index) => _model.setClickAction(index),
        ),
      ],
    );
  }
}
