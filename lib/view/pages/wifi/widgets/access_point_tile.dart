import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      case WifiStrengthLevel.veryLow:
        return isLocked
            ? MdiIcons.wifiStrengthLockOutline
            : MdiIcons.wifiStrengthOutline;
      case WifiStrengthLevel.low:
        return isLocked ? MdiIcons.wifiStrength1Lock : MdiIcons.wifiStrength1;
      case WifiStrengthLevel.medium:
        return isLocked ? MdiIcons.wifiStrength2Lock : MdiIcons.wifiStrength2;
      case WifiStrengthLevel.high:
        return isLocked ? MdiIcons.wifiStrength3Lock : MdiIcons.wifiStrength3;
      case WifiStrengthLevel.veryHigh:
        return isLocked ? MdiIcons.wifiStrength4Lock : MdiIcons.wifiStrength4;

      default:
        throw StateError('Illigal Satet $strengthLevel');
    }
  }
}
