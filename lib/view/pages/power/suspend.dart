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
        return 'Nothing';
      case PowerButtonAction.suspend:
        return 'Suspend';
      case PowerButtonAction.hibernate:
        return 'Hibernate';
      case PowerButtonAction.interactive:
        return 'Power Off';
      default:
        return context.l10n.unknown;
    }
  }
}
