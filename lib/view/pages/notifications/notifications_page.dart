import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/notifications/app_notifications_section.dart';
import 'package:settings/view/pages/notifications/global_notifications_section.dart';
import 'package:settings/view/pages/notifications/notifications_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = GetIt.instance.get<SettingsService>();
    return ChangeNotifierProvider<NotificationsModel>(
      create: (_) => NotificationsModel(service),
      child: const NotificationsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        GlobalNotificationsSection(),
        AppNotificationsSection(),
      ],
    );
  }
}
