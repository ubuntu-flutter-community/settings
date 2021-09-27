import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<String?> applicationChildren;

    if (GSettingsSchema.lookup(schemaNotifications) != null) {
      applicationChildren = GSettings(schemaId: schemaNotifications)
          .stringArrayValue('application-children');
    }

    return SettingsSection(
      schemaId: schemaNotifications + '.application',
      headline: 'App notifications',
      children: GSettingsSchema.lookup(schemaNotifications) != null
          ? applicationChildren.map(
              (appString) {
                const appSchemaId = schemaNotifications + '.application';
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
