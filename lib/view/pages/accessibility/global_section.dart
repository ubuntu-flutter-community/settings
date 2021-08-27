import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class GlobalSection extends StatelessWidget {
  const GlobalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsSection(
      headline: 'Global',
      children: [
        SingleGsettingRow(
          actionLabel: 'Always Show Universal Access Menu',
          settingsKey: 'always-show-universal-access-status',
          schemaId: 'org.gnome.desktop.a11y',
        ),
      ],
    );
  }
}
