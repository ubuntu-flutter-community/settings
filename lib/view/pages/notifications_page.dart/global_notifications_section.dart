import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class GlobalNotificationsSection extends StatefulWidget {
  const GlobalNotificationsSection({Key? key}) : super(key: key);

  @override
  _GlobalNotificationsSectionState createState() =>
      _GlobalNotificationsSectionState();
}

class _GlobalNotificationsSectionState
    extends State<GlobalNotificationsSection> {
  late GSettings _settings;

  @override
  void initState() {
    _settings = GSettings(schemaId: 'org.gnome.desktop.notifications');
    super.initState();
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(headline: 'Global', children: [
      BoolSettingsRow(
          actionLabel: 'Do not disturb',
          settingsKey: 'show-banners',
          settings: _settings),
      BoolSettingsRow(
          actionLabel: 'Show notifications on lockscreen',
          settingsKey: 'show-in-lock-screen',
          settings: _settings)
    ]);
  }
}
