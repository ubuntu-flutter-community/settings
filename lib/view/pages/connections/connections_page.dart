import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/connections/wifi_content.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

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
    return Column(
      children: [
        Container(
          width: 516,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
              tabs: const [
                Tab(
                    icon: Icon(YaruIcons.network_wireless),
                    child: Text("Wi-Fi")),
                Tab(
                    icon: Icon(YaruIcons.network_wired),
                    child: Text("Ethernet")),
                Tab(
                    icon: Icon(YaruIcons.network_cellular),
                    child: Text("Cellular")),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 1000,
            child: TabBarView(
              controller: tabController,
              children: [
                wifiModel.isWifiDeviceAvailable
                    ? const WifiDevicesContent()
                    : const WifiAdaptorNotFound(),
                Column(
                  children: const [Text('Ethernet')],
                ),
                Column(
                  children: const [Text('Cellular')],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
