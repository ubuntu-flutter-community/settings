import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_gsetting_row.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NotificationsModel>(context);

    return SettingsSection(
      schemaId: schemaNotifications + '.application',
      headline: 'App notifications',
      children: model.applications?.map(
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
          ).toList() ??
          const [Text('Schema not installed ')],
    );
  }
}
