import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

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
      create: (_) => AppNotificationsModel(appId, di<GSettingsService>()),
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
