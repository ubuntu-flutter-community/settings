import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class TypingSection extends StatelessWidget {
  const TypingSection({Key? key}) : super(key: key);

  final _schemaA11yApps = 'org.gnome.desktop.a11y.applications';

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      headline: 'Typing',
      children: [
        SingleGsettingRow(
          actionLabel: 'Screen Keyboard',
          schemaId: _schemaA11yApps,
          settingsKey: 'screen-keyboard-enabled',
        ),
      ],
    );
  }
}
