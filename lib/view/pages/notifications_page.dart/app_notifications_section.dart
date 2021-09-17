import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<String?> applicationChildren;

    const notificationSchemaId = 'org.gnome.desktop.notifications';

    if (GSettingsSchema.lookup(notificationSchemaId) != null) {
      applicationChildren = GSettings(schemaId: notificationSchemaId)
          .stringArrayValue('application-children');
    }

    return SettingsSection(
      schemaId: notificationSchemaId + '.application',
      headline: 'App notifications',
      children: GSettingsSchema.lookup(notificationSchemaId) != null
          ? applicationChildren.map(
              (appString) {
                const appSchemaId = notificationSchemaId + '.application';
                final path = '/' +
                    appSchemaId.replaceAll('.', '/') +
                    '/' +
                    appString.toString() +
                    '/';
                return SingleGsettingRow(
                  actionLabel: appString.toString(),
                  settingsKey: 'enable',
                  schemaId: appSchemaId,
                  path: path,
                );
              },
            ).toList()
          : const [Text('Schema not installed ')],
    );
  }
}
