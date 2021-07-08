import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class GlobalNotificationsSection extends StatelessWidget {
  const GlobalNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.notifications';

    return const SettingsSection(
        schemaId: _schemaId,
        headline: 'Global',
        children: [
          BoolSettingsRow(
            actionLabel: 'Do not disturb',
            settingsKey: 'show-banners',
            schemaId: _schemaId,
          ),
          BoolSettingsRow(
            actionLabel: 'Show notifications on lockscreen',
            settingsKey: 'show-in-lock-screen',
            schemaId: _schemaId,
          )
        ]);
  }
}
