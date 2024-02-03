import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/connections/models/access_point_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:yaru_icons/yaru_icons.dart';

import 'data/authentication.dart';
import 'models/wifi_model.dart';
import 'widgets/access_point_tile.dart';
import 'widgets/authentication_dialog.dart';

class WifiDevicesContent extends StatelessWidget {
  const WifiDevicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final wifiModel = context.watch<WifiModel>();

    return SettingsPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: YaruSwitchRow(
            enabled: wifiModel.isWifiDeviceAvailable,
            trailingWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.wifiPageTitle),
                Text(
                  wifiModel.isWifiEnabled
                      ? context.l10n.connected
                      : context.l10n.disconnected,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                ),
              ],
            ),
            onChanged: wifiModel.toggleWifi,
            value: wifiModel.isWifiEnabled,
          ),
        ),
        if (wifiModel.isWifiEnabled)
          for (final wifiDevice in wifiModel.wifiDevices)
            AnimatedBuilder(
              animation: wifiDevice,
              builder: (_, __) {
                return SettingsSection(
                  width: kDefaultWidth,
                  headline: Text(context.l10n.connectionsPageHeadline),
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
                          if (wifiModel.errorMessage.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(wifiModel.errorMessage),
                              ),
                            );
                          }
                        },
                      ),
                  ],
                );
              },
            ),
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

class WifiAdaptorNotFound extends StatelessWidget {
  const WifiAdaptorNotFound({super.key});

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
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'Make sure you have a Wi-Fi adaptor plugged and turned on',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
