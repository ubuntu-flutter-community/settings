import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'data/authentication.dart';
import 'models/wifi_model.dart';
import 'widgets/access_point_tile.dart';
import 'widgets/authentication_dialog.dart';

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
                    child: Text("WiFi")),
                Tab(
                    icon: Icon(YaruIcons.network_wired),
                    child: Text("Ethernet")),
                Tab(
                    icon: Icon(YaruIcons.call_incoming),
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
                    ? const _WifiDevicesContent()
                    : const _WifiAdaptorNotFound(),
                Column(),
                Column()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WifiDevicesContent extends StatelessWidget {
  const _WifiDevicesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();

    return Column(
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Wifi'),
          actionDescription:
              wifiModel.isWifiEnabled ? 'connected' : 'disconnected',
          onChanged: (newValue) => wifiModel.toggleWifi(newValue),
          value: wifiModel.isWifiEnabled,
        ),
        if (wifiModel.isWifiEnabled)
          for (final wifiDevice in wifiModel.wifiDevices)
            AnimatedBuilder(
                animation: wifiDevice,
                builder: (_, __) {
                  return YaruSection(
                    headline: 'Visible Networks',
                    children: [
                      for (final accessPoint in wifiDevice.accesPoints)
                        AccessPointTile(
                          accessPointModel: accessPoint,
                          onTap: () {
                            wifiModel.connectToAccesPoint(
                              accessPoint,
                              wifiDevice,
                              (wifiDevice, accessPoint) =>
                                  authenticate(context, accessPoint),
                            );
                          },
                        )
                    ],
                  );
                })
      ],
    );
  }

  Future<Authentication?> authenticate(
    BuildContext buildContext,
    AccessPointModel accessPointModel,
  ) {
    return showDialog<Authentication>(
      context: buildContext,
      builder: (context) => ChangeNotifierProvider.value(
        value: accessPointModel,
        child: AuthenticationDialog(),
      ),
    );
  }
}

class _WifiAdaptorNotFound extends StatelessWidget {
  const _WifiAdaptorNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FractionallySizedBox(
          widthFactor: .5,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Icon(YaruIcons.network_wireless_no_route),
          ),
        ),
        Text(
          'No Wi-fi Adaptor Found',
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          'Make sure you have a Wi-Fi adaptor plugged and turned on',
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }
}
