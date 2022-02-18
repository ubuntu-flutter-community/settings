import 'package:flutter/material.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/privacy/connectivity_page.dart';
import 'package:settings/view/pages/privacy/house_keeping_page.dart';
import 'package:settings/view/pages/privacy/location_page.dart';
import 'package:settings/view/pages/privacy/reporting_page.dart';
import 'package:settings/view/pages/privacy/screen_saver_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const PrivacyPage();

  @override
  Widget build(BuildContext context) {
    return YaruTabbedPage(width: kDefaultWidth * 2, tabIcons: const [
      YaruIcons.network,
      YaruIcons.location,
      YaruIcons.thunderbolt,
      YaruIcons.trash,
      YaruIcons.lock,
      YaruIcons.question
    ], tabTitles: const [
      'Connectivity',
      'Location Services',
      'Thunderbolt',
      'House Cleaning',
      'Screen Lock',
      'Diagnostics'
    ], views: [
      ConnectivityPage.create(context),
      LocationPage.create(context),
      const YaruPage(
          // TODO: implement Thunderbolt!
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Thunderbolt - Please implement 🥲️'),
            )
          ]),
      HouseKeepingPage.create(context),
      ScreenSaverPage.create(context),
      ReportingPage.create(context),
    ]);
  }
}
