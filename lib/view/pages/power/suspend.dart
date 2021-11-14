import 'package:flutter/widgets.dart';

enum PowerButtonAction {
  nothing,
  suspend,
  hibernate,
  interactive,
}

extension PowerButtonActionInt on int {
  PowerButtonAction? toPowerButtonAction() {
    if (this < 0 || this >= PowerButtonAction.values.length) return null;
    return PowerButtonAction.values[this];
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
        return 'Unknown';
    }
  }
}
