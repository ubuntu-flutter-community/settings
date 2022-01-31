import 'package:flutter/widgets.dart';

enum LidCloseAction {
  blank,
  suspend,
  shutdown,
  hibernate,
  interactive,
  nothing,
  logout
}

extension LidCloseActionString on String {
  LidCloseAction? toLidCloseAction() {
    try {
      return LidCloseAction.values.byName(this);
    } on ArgumentError {
      return null;
    }
  }
}

extension LidCloseActionL10n on LidCloseAction {
  String localize(BuildContext context) {
    switch (this) {
      case LidCloseAction.blank:
        return 'Blank';
      case LidCloseAction.suspend:
        return 'Suspend';
      case LidCloseAction.shutdown:
        return 'Shutdown';
      case LidCloseAction.hibernate:
        return 'Hibernate';
      case LidCloseAction.interactive:
        return 'Interactive';
      case LidCloseAction.nothing:
        return 'Nothing';
      case LidCloseAction.logout:
        return 'Logout';
      default:
        return 'Unknown';
    }
  }
}
