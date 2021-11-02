import 'package:flutter/material.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

import '../../../widgets/extra_options_gsettings_row.dart';
import '../../../widgets/settings_row.dart';
import '../models/wifi_model.dart';

class AccessPointTile extends StatelessWidget {
  final AccessPointModel accessPointModel;
  final VoidCallback onTap;
  const AccessPointTile({
    required this.accessPointModel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: accessPointModel,
        builder: (_, __) {
          return InkWell(
            onTap: onTap,
            child: SettingsRow(
              trailingWidget: Text(accessPointModel.ssid),
              leadingWidget: Icon(accessPointModel.wifiIconData),
              actionWidget: Row(
                children: [
                  Icon(accessPointModel.isActiveIconData),
                  const SizedBox(width: 8.0),
                  OptionsButton(onPressed: () {
                    // TODO: navigate to wifi access point details dialog
                  }),
                ],
              ),
            ),
          );
        });
  }
}

extension _AccessPointX on AccessPointModel {
  IconData? get isActiveIconData {
    if (isActive) return Icons.done;
    return null;
  }

  IconData get wifiIconData {
    switch (strengthLevel) {
      case WifiStrengthLevel.none:
        return isLocked
            ? YaruIcons.network_wireless_signal_none_secure
            : YaruIcons.network_wireless_signal_none;
      case WifiStrengthLevel.weak:
        return isLocked
            ? YaruIcons.network_wireless_signal_weak_secure
            : YaruIcons.network_wireless_signal_weak;
      case WifiStrengthLevel.ok:
        return isLocked
            ? YaruIcons.network_wireless_signal_ok_secure
            : YaruIcons.network_wireless_signal_ok;
      case WifiStrengthLevel.good:
        return isLocked
            ? YaruIcons.network_wireless_signal_good_secure
            : YaruIcons.network_wireless_signal_good;
      case WifiStrengthLevel.excellent:
        return isLocked
            ? YaruIcons.network_wireless_signal_excellent_secure
            : YaruIcons.network_wireless_signal_excellent;

      default:
        throw StateError('Illigal Satet $strengthLevel');
    }
  }
}
