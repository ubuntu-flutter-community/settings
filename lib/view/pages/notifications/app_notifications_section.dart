import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:settings/view/settings_section.dart';
import 'package:ubuntu_service/ubuntu_service.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NotificationsModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('App notifications'),
      children: model.applications
              ?.map(
                (appId) =>
                    AppNotificationsSettingRow.create(context, appId: appId),
              )
              .toList() ??
          const [Text('Schema not installed ')],
    );
  }
}

class AppNotificationsSettingRow extends StatelessWidget {
  const AppNotificationsSettingRow({super.key});

  static Widget create(BuildContext context, {required String appId}) {
    return ChangeNotifierProvider(
      create: (_) =>
          AppNotificationsModel(appId, getService<SettingsService>()),
      child: const AppNotificationsSettingRow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AppNotificationsModel>();
    return YaruSwitchRow(
      trailingWidget: Text(model.appId),
      value: model.enable,
      onChanged: model.setEnable,
    );
  }
}
