import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/connections/wifi_content.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'models/wifi_model.dart';

class ConnectionsPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final service = Provider.of<NetworkManagerClient>(context, listen: false);
    return ChangeNotifierProvider<WifiModel>(
      create: (_) => WifiModel(service),
      child: const ConnectionsPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      YaruPageItemTitle.text(context.l10n.connectionsPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.connectionsPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();
    return YaruTabbedPage(
      tabIcons: const [
        YaruIcons.network_wireless,
        YaruIcons.network_wired,
        YaruIcons.network_cellular
      ],
      tabTitles: const ['Wi-Fi', 'Ethernet', 'Cellular'],
      views: [
        wifiModel.isWifiDeviceAvailable
            ? const WifiDevicesContent()
            : const WifiAdaptorNotFound(),
        const SettingsPage(
          children: [
            // TODO: Implement Ethernet page
            Text('Ethernet - Please implement 🥲️'),
          ],
        ),
        const SettingsPage(
          children: [
            // TODO: Implement Cellular page
            Text('Cellular - Please implement 🥲️'),
          ],
        ),
      ],
      width: kDefaultWidth,
    );
  }
}
