import 'package:flutter/widgets.dart';

enum AutomaticSuspend {
  off,
  battery,
  pluggedIn,
  both,
}

extension AutomaticSuspendL10n on AutomaticSuspend {
  String localize(BuildContext context) {
    switch (this) {
      case AutomaticSuspend.off:
        return 'Off';
      case AutomaticSuspend.battery:
        return 'When on battery power';
      case AutomaticSuspend.pluggedIn:
        return 'When plugged in';
      case AutomaticSuspend.both:
        return 'On';
      default:
        return 'Unknown';
    }
  }
}

enum SleepInactiveType {
  blank,
  suspend,
  shutdown,
  hibernate,
  interactive,
  nothing,
  logout,
}

extension SleepInactiveTypeInt on int {
  SleepInactiveType? toSleepInactiveType() {
    if (this < 0 || this >= SleepInactiveType.values.length) return null;
    return SleepInactiveType.values[this];
  }
}

class IdleDelay {
  static const values = <int>[
    1 * 60,
    2 * 60,
    3 * 60,
    4 * 60,
    5 * 60,
    8 * 60,
    10 * 60,
    12 * 60,
    15 * 60,
    0,
  ];

  static int? validate(int? delay) => values.contains(delay) ? delay : null;
}

class SuspendDelay {
  static const values = <int>[
    15 * 60,
    20 * 60,
    25 * 60,
    30 * 60,
    45 * 60,
    60 * 60,
    80 * 60,
    90 * 60,
    100 * 60,
    120 * 60,
  ];

  static int? validate(int? delay) => values.contains(delay) ? delay : null;
}
