import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';
import 'package:settings/view/widgets/slider_gsetting_row.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({Key? key}) : super(key: key);

  final _schemaA11yKeyboard = 'org.gnome.desktop.a11y.keyboard';
  final _schemaInterface = 'org.gnome.desktop.interface';
  final _schemaPeripheralsMouse = 'org.gnome.settings-daemon.peripherals.mouse';

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      headline: 'Pointing & Clicking',
      children: [
        SingleGsettingRow(
          actionLabel: 'Mouse Keys',
          settingsKey: 'mousekeys-enable',
          schemaId: _schemaA11yKeyboard,
        ),
        SingleGsettingRow(
          actionLabel: 'Locate Pointer',
          settingsKey: 'locate-pointer',
          schemaId: _schemaInterface,
        ),
        SliderGsettingRow(
          actionLabel: 'Double-Click Delay',
          settingsKey: 'double-click',
          schemaId: _schemaPeripheralsMouse,
          discrete: true,
          min: 100,
          max: 1000,
        ),
      ],
    );
  }
}
