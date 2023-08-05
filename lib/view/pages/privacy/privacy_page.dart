import 'package:flutter/material.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/privacy/connectivity_page.dart';
import 'package:settings/view/pages/privacy/house_keeping_page.dart';
import 'package:settings/view/pages/privacy/location_page.dart';
import 'package:settings/view/pages/privacy/reporting_page.dart';
import 'package:settings/view/pages/privacy/screen_saver_page.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/tabbed_page.dart';
import 'package:yaru_icons/yaru_icons.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  static Widget create(BuildContext context) => const PrivacyPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.privacyPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.privacyPageTitle
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              context.l10n.connectivityPageTitle
                  .toLowerCase()
                  .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return TabbedPage(
      width: kDefaultWidth * 2,
      tabIcons: const [
        Icon(YaruIcons.network),
        Icon(YaruIcons.location),
        Icon(YaruIcons.thunderbolt),
        Icon(YaruIcons.trash),
        Icon(YaruIcons.lock),
        Icon(YaruIcons.question),
      ],
      tabTitles: [
        context.l10n.connectivityPageTitle,
        context.l10n.locationPageTitle,
        context.l10n.thunderBoltPageTitle,
        context.l10n.houseKeepingPageTitle,
        context.l10n.screenLockPageTitle,
        context.l10n.diagnosisPageTitle
      ],
      views: [
        ConnectivityPage.create(context),
        LocationPage.create(context),
        const SettingsPage(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Thunderbolt - Please implement 🥲️'),
            )
          ],
        ),
        HouseKeepingPage.create(context),
        ScreenSaverPage.create(context),
        ReportingPage.create(context),
      ],
    );
  }
}
