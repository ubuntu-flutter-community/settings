import 'package:flutter/material.dart';
import 'package:settings/view/pages/power/power_utils.dart';
import 'package:upower/upower.dart';
import 'package:settings/l10n/l10n.dart';

class BatteryStateLabel extends StatelessWidget {
  const BatteryStateLabel({
    Key? key,
    required this.state,
    required this.percentage,
    required this.timeToFull,
    required this.timeToEmpty,
  }) : super(key: key);

  final UPowerDeviceState? state;
  final double percentage;
  final int timeToFull;
  final int timeToEmpty;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case UPowerDeviceState.charging:
        return Text('${formatTime(timeToFull)} until fully charged');
      case UPowerDeviceState.discharging:
      case UPowerDeviceState.pendingDischarge:
        if (percentage < 20) {
          return Text('Caution: ${formatTime(timeToEmpty)} remaining');
        }
        return Text('${formatTime(timeToEmpty)} remaining');
      case UPowerDeviceState.fullyCharged:
        return const Text('Fully charged');
      case UPowerDeviceState.pendingCharge:
        return const Text('Not charging');
      case UPowerDeviceState.empty:
        return const Text('Empty');
      case UPowerDeviceState.unknown:
      default:
        return Text(context.l10n.unknown);
    }
  }
}
