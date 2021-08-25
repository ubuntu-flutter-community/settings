import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SettingsSection(
          headline: 'System',
          children: [
            SingleGsettingRow(
              actionLabel: 'Allow Volume above 100%',
              settingsKey: 'allow-volume-above-100-percent',
              schemaId: 'org.gnome.desktop.sound',
            ),
            SingleGsettingRow(
              actionLabel: 'Event sounds',
              settingsKey: 'event-sounds',
              schemaId: 'org.gnome.desktop.sound',
            ),
            SingleGsettingRow(
              actionLabel: 'Input feedback sounds',
              settingsKey: 'input-feedback-sounds',
              schemaId: 'org.gnome.desktop.sound',
            ),
          ],
        ),
      ],
    );
  }
}
