import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class MouseSection extends StatelessWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.mouse';

    return const SettingsSection(
        schemaId: _schemaId,
        headline: 'Mouse',
        children: [
          SliderRow(
            min: -1.0,
            actionLabel: 'Speed',
            settingsKey: 'speed',
            schemaId: _schemaId,
          ),
          BoolSettingsRow(
            actionLabel: 'Natural Scrolling',
            settingsKey: 'natural-scroll',
            schemaId: _schemaId,
          )
        ]);
  }
}
