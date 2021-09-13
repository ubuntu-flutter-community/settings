import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';
import 'package:settings/view/widgets/slider_gsetting_row.dart';
import 'package:settings/view/widgets/toggle_buttons_gsetting_row.dart';

class DockSection extends StatefulWidget {
  const DockSection({Key? key}) : super(key: key);

  @override
  State<DockSection> createState() => _DockSectionState();
}

class _DockSectionState extends State<DockSection> {
  final _schemaId = 'org.gnome.shell.extensions.dash-to-dock';
  late GSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = GSettings(schemaId: _schemaId);
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GSettingsSchema.lookup(_schemaId) == null) {
      return SettingsSection(
        headline: 'Dock Settings - Schema not installed!',
        children: const [],
        schemaId: _schemaId,
      );
    }

    return SettingsSection(
      schemaId: _schemaId,
      headline: 'Dock Settings',
      children: [
        SingleGsettingRow(
          actionLabel: 'Show trash',
          settingsKey: 'show-trash',
          schemaId: _schemaId,
        ),
        SingleGsettingRow(
          actionLabel: 'Always show the dock',
          settingsKey: 'dock-fixed',
          schemaId: _schemaId,
        ),
        SingleGsettingRow(
          actionLabel: 'Extend the height of the dock',
          settingsKey: 'extend-height',
          schemaId: _schemaId,
        ),
        SingleGsettingRow(
          actionLabel: 'Active app glow',
          settingsKey: 'unity-backlit-items',
          schemaId: _schemaId,
        ),
        SliderGsettingRow(
          actionLabel: 'Max icon size',
          settingsKey: 'dash-max-icon-size',
          schemaId: _schemaId,
          min: 16,
          max: 64,
          divisions: 24,
          discrete: true,
        ),
        ToggleButtonsGsettingRow(
          actionLabel: 'Dock position',
          settingsKey: 'dock-position',
          schemaId: _schemaId,
          settingsValues: const [
            'LEFT',
            'RIGHT',
            'BOTTOM',
          ],
          buttonLabels: const [
            'Left',
            'Right',
            'Bottom',
          ],
        ),
        ToggleButtonsGsettingRow(
          actionLabel: 'App icon click behavior',
          settingsKey: 'click-action',
          schemaId: _schemaId,
          settingsValues: const [
            'minimize',
            'focus-or-previews',
          ],
          buttonLabels: const [
            'Minimize',
            'Focus or previews',
          ],
        ),
      ],
    );
  }
}
