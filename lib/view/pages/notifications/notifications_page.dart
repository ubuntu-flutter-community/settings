import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/notifications/app_notifications_section.dart';
import 'package:settings/view/pages/notifications/global_notifications_section.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<NotificationsModel>(
      create: (_) => NotificationsModel(service),
      child: const NotificationsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const YaruPage(
      children: [
        GlobalNotificationsSection(),
        AppNotificationsSection(),
      ],
    );
  }
}
