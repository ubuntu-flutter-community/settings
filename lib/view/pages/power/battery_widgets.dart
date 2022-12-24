import 'package:flutter/material.dart';
import 'package:settings/utils.dart';
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
        return Text(context.l10n.batteryCharging(formatTime(timeToFull)));
      case UPowerDeviceState.discharging:
      case UPowerDeviceState.pendingDischarge:
        if (percentage < 20) {
          return Text(context.l10n.batteryLow(formatTime(timeToEmpty)));
        }
        return Text(context.l10n.batteryDischarging(formatTime(timeToEmpty)));
      case UPowerDeviceState.fullyCharged:
        return Text(context.l10n.batteryFullyCharged);
      case UPowerDeviceState.pendingCharge:
        return Text(context.l10n.batteryNotCharging);
      case UPowerDeviceState.empty:
        return Text(context.l10n.batteryEmpty);
      case UPowerDeviceState.unknown:
      default:
        return Text(context.l10n.unknown);
    }
  }
}
