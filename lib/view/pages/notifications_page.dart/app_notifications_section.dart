import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NotificationsModel>(context);

    return SettingsSection(
      schemaId: schemaNotifications + '.application',
      headline: 'App notifications',
      children: model.applications
              ?.map((appId) =>
                  AppNotificationsSettingRow.create(context, appId: appId))
              .toList() ??
          const [Text('Schema not installed ')],
    );
  }
}

class AppNotificationsSettingRow extends StatelessWidget {
  const AppNotificationsSettingRow({Key? key}) : super(key: key);

  static Widget create(BuildContext context, {required String appId}) {
    return ChangeNotifierProvider(
      create: (_) => AppNotificationsModel(appId),
      child: const AppNotificationsSettingRow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppNotificationsModel>(context);
    return SwitchSettingsRow(
      actionLabel: model.appId,
      value: model.enable,
      onChanged: model.setEnable,
    );
  }
}
