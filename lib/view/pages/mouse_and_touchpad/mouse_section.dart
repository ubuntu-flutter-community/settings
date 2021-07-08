import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/settings_row.dart';

class MouseSection extends StatelessWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.mouse';
    final _settings = GSettings(schemaId: _schemaId);
    return SettingsSection(schemaId: _schemaId, headline: 'Mouse', children: [
      SliderRow(
          min: -1.0,
          actionLabel: 'Speed',
          settingsKey: 'speed',
          settings: _settings),
      BoolSettingsRow(
          actionLabel: 'Natural Scrolling',
          settingsKey: 'natural-scroll',
          settings: _settings)
    ]);
  }
}
