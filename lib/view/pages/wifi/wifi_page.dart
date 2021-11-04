import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

import '../../widgets/settings_section.dart';
import '../../widgets/switch_settings_row.dart';
import 'data/authentication.dart';
import 'models/wifi_model.dart';
import 'widgets/access_point_tile.dart';
import 'widgets/authentication_dialog.dart';

class WifiPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final service = Provider.of<NetworkManagerClient>(context, listen: false);
    return ChangeNotifierProvider<WifiModel>(
      create: (_) => WifiModel(service),
      child: const WifiPage(),
    );
  }

  const WifiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();
    if (wifiModel.isWifiDeviceAvailable) return const _WifiDevicesContent();
    return const _WifiAdaptorNotFound();
  }
}

class _WifiDevicesContent extends StatelessWidget {
  const _WifiDevicesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();

    return Column(
      children: [
        SwitchSettingsRow(
          trailingWidget: const Text('Wifi'),
          actionDescription:
              wifiModel.isWifiEnabled ? 'connected' : 'disconnected',
          onChanged: (newValue) => wifiModel.toggleWifi(newValue),
          value: wifiModel.isWifiEnabled,
        ),
        if (wifiModel.isWifiEnabled)
          for (final wifiAdaptor in wifiModel.wifiDevices)
            AnimatedBuilder(
                animation: wifiAdaptor,
                builder: (_, __) {
                  return SettingsSection(
                    headline: wifiAdaptor.interface,
                    children: [
                      for (final accessPoint in wifiAdaptor.accesPoints)
                        AccessPointTile(
                          accessPointModel: accessPoint,
                          onTap: () {
                            wifiModel.connectToAccesPoint(
                              accessPoint,
                              wifiAdaptor,
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
