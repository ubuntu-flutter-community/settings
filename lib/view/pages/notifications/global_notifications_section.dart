import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class GlobalNotificationsSection extends StatelessWidget {
  const GlobalNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NotificationsModel>(context);

    return YaruSection(
      headline: 'Global',
      children: [
        YaruSwitchRow(
          mainWidget: const Text('Do Not Disturb'),
          value: model.doNotDisturb,
          onChanged: model.setDoNotDisturb,
        ),
        YaruSwitchRow(
          mainWidget: const Text('Show Notifications On Lock Screen'),
          value: model.showOnLockScreen,
          onChanged: model.setShowOnLockScreen,
        ),
      ],
    );
  }
}
