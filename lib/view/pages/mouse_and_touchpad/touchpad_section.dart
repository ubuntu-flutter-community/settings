import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/settings_row.dart';

class TouchpadSection extends StatelessWidget {
  const TouchpadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.touchpad';

    return const SettingsSection(
        schemaId: _schemaId,
        headline: 'Touchpad',
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
          ),
          BoolSettingsRow(
            actionLabel: 'Tap to click',
            settingsKey: 'tap-to-click',
            schemaId: _schemaId,
          ),
          BoolSettingsRow(
            actionLabel: 'Disable while typing',
            settingsKey: 'disable-while-typing',
            schemaId: _schemaId,
          )
        ]);
  }
}
