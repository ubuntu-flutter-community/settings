import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';

enum PowerButtonAction {
  nothing,
  suspend,
  hibernate,
  interactive,
}

extension PowerButtonActionString on String {
  PowerButtonAction? toPowerButtonAction() {
    try {
      return PowerButtonAction.values.byName(this);
    } on ArgumentError {
      return null;
    }
  }
}

extension PowerButtonActionL10n on PowerButtonAction {
  String localize(BuildContext context) {
    switch (this) {
      case PowerButtonAction.nothing:
        return context.l10n.powerButtonActionNothing;
      case PowerButtonAction.suspend:
        return context.l10n.powerButtonActionSuspend;
      case PowerButtonAction.hibernate:
        return context.l10n.powerButtonActionHibernate;
      case PowerButtonAction.interactive:
        return context.l10n.powerButtonActionPowerOff;
      default:
        return context.l10n.unknown;
    }
  }
}
