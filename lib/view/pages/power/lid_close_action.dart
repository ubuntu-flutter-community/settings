import 'package:settings/l10n/l10n.dart';

enum LidCloseAction {
  blank,
  suspend,
  shutdown,
  hibernate,
  interactive,
  nothing,
  logout;

  String localize(AppLocalizations l10n) {
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
        return l10n.unknown;
    }
  }
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
