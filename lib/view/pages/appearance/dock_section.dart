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
    final model = Provider.of<AppearanceModel>(context);

    return SettingsSection(
      headline: 'Dock',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Show Trash',
          value: model.getShowTrash,
          onChanged: (value) => model.setShowTrash(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Always Show Dock',
          value: model.getAlwaysShowDock,
          onChanged: (value) => model.setAlwaysShowDock(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Extend Dock',
          value: model.getExtendDock,
          onChanged: (value) => model.setExtendDock(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Active App Glow',
          value: model.getAppGlow,
          onChanged: (value) => model.setAppGlow(value),
        ),
        SliderSettingsRow(
          actionLabel: 'Icon Size',
          value: model.getMaxIconSize,
          min: 16,
          max: 64,
          onChanged: (value) => model.setMaxIconSize(value),
        ),
        ToggleButtonsSettingRow(
          actionLabel: 'Dock Position',
          selectedValues: model.getSelectedDockPositions,
          labels: const ['Left', 'Right', 'Bottom'],
          onPressed: (index) => model.setDockPosition(index),
        ),
        ToggleButtonsSettingRow(
          actionLabel: 'App Icon Click Behaviour',
          selectedValues: model.getSelectedClickActions,
          labels: const ['Minimize', 'Focus or previews'],
          onPressed: (index) => model.setClickAction(index),
        ),
      ],
    );
  }
}
