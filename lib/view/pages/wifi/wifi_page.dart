import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';

import '../../widgets/settings_section.dart';
import '../../widgets/switch_settings_row.dart';
import 'models/wifi_model.dart';
import 'widgets/access_point_tile.dart';

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

    if (wifiModel.isWifiAdaptorAvailable) return _WifiAdaptorsContent();

    return _WifiAdaptorNotFound();
  }
}

class _WifiAdaptorsContent extends StatelessWidget {
  const _WifiAdaptorsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.read<WifiModel>();

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
          for (final wifiAdaptor in wifiModel.wifiAdaptors)
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
                            );
                          },
                        )
                    ],
                  );
                })
      ],
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
        FractionallySizedBox(
          widthFactor: .5,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Icon(MdiIcons.wifiOff),
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
