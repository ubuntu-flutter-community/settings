import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<String?> _applicationChildren;

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
              const _appSchemaId = _notificationSchemaId + '.application';
              final _path = '/' + appString.toString() + '/';
              return SingleGsettingRow(
                  actionLabel: appString.toString(),
                  settingsKey: 'enable',
                  schemaId: _appSchemaId,
                  path: _path);
            }).toList()
          : const [Text('Schema not installed ')],
    );
  }
}
