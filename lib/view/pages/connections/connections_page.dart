import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/title_bar_tab.dart';
import 'package:settings/view/pages/connections/wifi_content.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'models/wifi_model.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<WifiModel>(
      create: (_) => WifiModel(getService<NetworkManagerClient>()),
      child: const ConnectionsPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.connectionsPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.connectionsPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: YaruWindowTitleBar(
          titleSpacing: 20,
          centerTitle: true,
          border: BorderSide.none,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const SizedBox(
            width: 400,
            child: TabBar(
              tabs: [
                TitleBarTab(
                  text: 'Wi-Fi',
                  iconData: YaruIcons.network_wireless,
                ),
                TitleBarTab(
                  text: 'Ethernet',
                  iconData: YaruIcons.network_wired,
                ),
                TitleBarTab(
                  iconData: YaruIcons.network_cellular,
                  text: 'Cellular',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            wifiModel.isWifiDeviceAvailable
                ? const WifiDevicesContent()
                : const WifiAdaptorNotFound(),
            const SettingsPage(
              children: [
                Text('Ethernet - Please implement 🥲️'),
              ],
            ),
            const SettingsPage(
              children: [
                Text('Cellular - Please implement 🥲️'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
