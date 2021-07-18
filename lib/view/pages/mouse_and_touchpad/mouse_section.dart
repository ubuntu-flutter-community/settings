import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';
import 'package:settings/view/widgets/slider_gsetting_row.dart';

class MouseSection extends StatelessWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.mouse';

    return const SettingsSection(
        schemaId: _schemaId,
        headline: 'Mouse',
        children: [
          SliderGsettingRow(
            min: -1.0,
            max: 1.0,
            discrete: false,
            actionLabel: 'Speed',
            settingsKey: 'speed',
            schemaId: _schemaId,
          ),
          SingleGsettingRow(
            actionLabel: 'Natural Scrolling',
            settingsKey: 'natural-scroll',
            schemaId: _schemaId,
          )
        ]);
  }
}
