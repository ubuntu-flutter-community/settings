import 'package:flutter/material.dart';
import 'package:settings/view/pages/connections/models/access_point_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AccessPointTile extends StatelessWidget {
  const AccessPointTile({
    required this.accessPointModel,
    required this.onTap,
    super.key,
  });
  final AccessPointModel accessPointModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessPointModel,
      builder: (_, __) {
        return InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: YaruTile(
            title: Row(
              children: [
                Icon(accessPointModel.wifiIconData),
                const SizedBox(
                  width: 10,
                ),
                Text(accessPointModel.name),
              ],
            ),
            trailing: Row(
              children: [
                Icon(accessPointModel.isActiveIconData),
                const SizedBox(width: 8.0),
                YaruOptionButton(
                  onPressed: () {},
                  child: const Icon(YaruIcons.gear),
                ),
              ],
            ),
          ),
        );
      },
    );
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
