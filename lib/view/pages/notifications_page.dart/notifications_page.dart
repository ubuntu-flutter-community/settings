import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/notifications_page.dart/app_notifications_section.dart';
import 'package:settings/view/pages/notifications_page.dart/global_notifications_section.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<NotificationsModel>(
      create: (_) => NotificationsModel(),
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
