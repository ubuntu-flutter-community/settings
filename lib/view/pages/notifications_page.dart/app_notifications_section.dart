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
  late List<String?> _applicationChildren;

  @override
  Widget build(BuildContext context) {
    const _notificationSchemaId = 'org.gnome.desktop.notifications';

    if (GSettingsSchema.lookup(_notificationSchemaId) != null) {
      _applicationChildren = GSettings(schemaId: _notificationSchemaId)
          .stringArrayValue('application-children');
    }

    return SettingsSection(
      schemaId: _notificationSchemaId + '.application',
      headline: 'App notifications',
      children: GSettingsSchema.lookup(_notificationSchemaId) != null
          ? _applicationChildren.map((appString) {
              final _appNotificationSettings = GSettings(
                  schemaId: _notificationSchemaId + '.application',
                  path: '/' + appString.toString() + '/');
              return BoolSettingsRow(
                  actionLabel: appString.toString(),
                  settingsKey: 'enable',
                  settings: _appNotificationSettings);
            }).toList()
          : const [Text('Schema not installed ')],
    );
  }
}
