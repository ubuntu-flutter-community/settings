import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AppNotificationsSection extends StatelessWidget {
  const AppNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NotificationsModel>();

    return YaruSection(
      width: kDefaultWidth,
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
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => AppNotificationsModel(appId, service),
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
