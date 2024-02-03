import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/title_bar_tab.dart';
import 'package:settings/view/pages/privacy/connectivity_page.dart';
import 'package:settings/view/pages/privacy/house_keeping_page.dart';
import 'package:settings/view/pages/privacy/location_page.dart';
import 'package:settings/view/pages/privacy/reporting_page.dart';
import 'package:settings/view/pages/privacy/screen_saver_page.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

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
    final content = <Widget, (IconData, String)>{
      ConnectivityPage.create(context): (
        YaruIcons.network,
        context.l10n.connectivityPageTitle
      ),
      LocationPage.create(context): (
        YaruIcons.location,
        context.l10n.locationPageTitle
      ),
      const SettingsPage(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Thunderbolt - Please implement 🥲️'),
          ),
        ],
      ): (YaruIcons.thunderbolt, context.l10n.thunderBoltPageTitle),
      HouseKeepingPage.create(context): (
        YaruIcons.trash,
        context.l10n.houseKeepingPageTitle
      ),
      ScreenSaverPage.create(context): (
        YaruIcons.lock,
        context.l10n.screenLockPageTitle
      ),
      ReportingPage.create(context): (
        YaruIcons.question,
        context.l10n.diagnosisPageTitle
      ),
    };

    return DefaultTabController(
      length: content.length,
      child: Scaffold(
        appBar: YaruWindowTitleBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          border: BorderSide.none,
          title: TabBar(
            isScrollable: true,
            tabs: content.entries
                .map((e) => TitleBarTab(text: e.value.$2, iconData: e.value.$1))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: content.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: kYaruPagePadding),
                  child: e.key,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
