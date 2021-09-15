import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class GlobalNotificationsSection extends StatelessWidget {
  const GlobalNotificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NotificationsModel>(context);

    return SettingsSection(
      headline: 'Global',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Do Not Disturb',
          value: model.doNotDisturb,
          onChanged: (value) => model.setDoNotDisturb(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Show Notifications On Lock Screen',
          value: model.showOnLockScreen,
          onChanged: (value) => model.setShowOnLockScreen(value),
        ),
      ],
    );
  }
}
