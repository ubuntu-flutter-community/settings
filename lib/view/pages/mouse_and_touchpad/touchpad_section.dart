import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';
import 'package:settings/view/widgets/slider_gsetting_row.dart';

class TouchpadSection extends StatelessWidget {
  const TouchpadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.peripherals.touchpad';

    return const SettingsSection(
      schemaId: _schemaId,
      headline: 'Touchpad',
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
        ),
        SingleGsettingRow(
          actionLabel: 'Tap to click',
          settingsKey: 'tap-to-click',
          schemaId: _schemaId,
        ),
        SingleGsettingRow(
          actionLabel: 'Disable while typing',
          settingsKey: 'disable-while-typing',
          schemaId: _schemaId,
        ),
      ],
    );
  }
}
