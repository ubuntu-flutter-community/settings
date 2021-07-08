import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/settings_row.dart';

class TouchpadSection extends StatefulWidget {
  const TouchpadSection({Key? key}) : super(key: key);

  @override
  State<TouchpadSection> createState() => _TouchpadSectionState();
}

class _TouchpadSectionState extends State<TouchpadSection> {
  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.touchpad';
    final _settings = GSettings(schemaId: _schemaId);

    return SettingsSection(
        schemaId: _schemaId,
        headline: 'Touchpad',
        children: [
          SliderRow(
              min: -1.0,
              actionLabel: 'Speed',
              settingsKey: 'speed',
              settings: _settings),
          BoolSettingsRow(
              actionLabel: 'Natural Scrolling',
              settingsKey: 'natural-scroll',
              settings: _settings),
          BoolSettingsRow(
              actionLabel: 'Tap to click',
              settingsKey: 'tap-to-click',
              settings: _settings),
          BoolSettingsRow(
              actionLabel: 'Disable while typing',
              settingsKey: 'disable-while-typing',
              settings: _settings)
        ]);
  }
}
