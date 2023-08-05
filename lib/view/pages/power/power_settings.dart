import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';

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
        return context.l10n.powerAutomaticSuspendOff;
      case AutomaticSuspend.battery:
        return context.l10n.powerAutomaticSuspendBattery;
      case AutomaticSuspend.pluggedIn:
        return context.l10n.powerAutomaticSuspendPluggedIn;
      case AutomaticSuspend.both:
        return context.l10n.powerAutomaticSuspendBoth;
      default:
        return context.l10n.unknown;
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

extension SleepInactiveTypeString on String {
  SleepInactiveType? toSleepInactiveType() {
    try {
      return SleepInactiveType.values.byName(this);
    } on ArgumentError {
      return null;
    }
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

class ScreenLockDelay {
  static const values = <int>[
    30,
    1 * 60,
    2 * 60,
    3 * 60,
    5 * 60,
    30 * 60,
    60 * 60,
    0,
  ];

  static int? validate(int? delay) => values.contains(delay) ? delay : null;
}
