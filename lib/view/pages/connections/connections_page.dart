import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/connections/wifi_content.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'models/wifi_model.dart';

class ConnectionsPage extends StatefulWidget {
  static Widget create(BuildContext context) {
    final service = Provider.of<NetworkManagerClient>(context, listen: false);
    return ChangeNotifierProvider<WifiModel>(
      create: (_) => WifiModel(service),
      child: const ConnectionsPage(),
    );
  }

  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();
    return YaruTabbedPage(tabIcons: const [
      YaruIcons.network_wireless,
      YaruIcons.network_wired,
      YaruIcons.network_cellular
    ], tabTitles: const [
      'Wi-Fi',
      'Ethernet',
      'Cellular'
    ], views: [
      wifiModel.isWifiDeviceAvailable
          ? const WifiDevicesContent()
          : const WifiAdaptorNotFound(),
      Column(
        children: const [Text('Ethernet')],
      ),
      Column(
        children: const [Text('Cellular')],
      )
    ], width: kDefaultWidth);
  }
}
