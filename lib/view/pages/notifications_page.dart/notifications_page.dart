import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/notifications_page.dart/app_notifications_section.dart';
import 'package:settings/view/pages/notifications_page.dart/global_notifications_section.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

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
