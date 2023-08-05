import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:settings/view/settings_section.dart';

class GlobalNotificationsSection extends StatelessWidget {
  const GlobalNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NotificationsModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('Global'),
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Do Not Disturb'),
          value: model.doNotDisturb,
          onChanged: (value) => model.setDoNotDisturb(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Show Notifications On Lock Screen'),
          value: model.showOnLockScreen,
          onChanged: (value) => model.setShowOnLockScreen(value),
        ),
      ],
    );
  }
}
