import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class AppNotificationsSection extends StatefulWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  _AppNotificationsSectionState createState() =>
      _AppNotificationsSectionState();
}

class _AppNotificationsSectionState extends State<AppNotificationsSection> {
  late GSettings _settings;
  late GSettings _appNotifcationSettings;
  late List<String?> _applicationChildren;

  @override
  void initState() {
    _settings = GSettings(schemaId: 'org.gnome.desktop.notifications');
    super.initState();
  }

  @override
  void dispose() {
    _settings.dispose();
    _appNotifcationSettings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _applicationChildren = _settings.stringArrayValue('application-children');

    return SettingsSection(
      headline: 'App notifications',
      children: _applicationChildren.map((appString) {
        _appNotifcationSettings = GSettings(
            schemaId: _settings.schemaId + '.application',
            path: '/' + appString.toString() + '/');
        return BoolSettingsRow(
            actionLabel: appString.toString(),
            settingsKey: 'enable',
            settings: _appNotifcationSettings);
      }).toList(),
    );
  }
}
