import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class SeeingSection extends StatelessWidget {
  const SeeingSection({Key? key}) : super(key: key);

  final _schemaA11yApps = 'org.gnome.desktop.a11y.applications';
  final _schemaA11yKeyboard = 'org.gnome.desktop.a11y.keyboard';

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      headline: 'Seeing',
      children: [
        SingleGsettingRow(
          actionLabel: 'Screen Reader',
          settingsKey: 'screen-reader-enabled',
          schemaId: _schemaA11yApps,
        ),
        SingleGsettingRow(
          actionLabel: 'Sound Keys',
          actionDescription:
              'Beep when Num Lock or Caps Lock are turned on or off',
          settingsKey: 'togglekeys-enable',
          schemaId: _schemaA11yKeyboard,
        ),
      ],
    );
  }
}
