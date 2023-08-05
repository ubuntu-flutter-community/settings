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
        return l10n.lidCloseActionBlank;
      case LidCloseAction.suspend:
        return l10n.lidCloseActionSuspend;
      case LidCloseAction.shutdown:
        return l10n.lidCloseActionShutdown;
      case LidCloseAction.hibernate:
        return l10n.lidCloseActionHibernate;
      case LidCloseAction.interactive:
        return l10n.lidCloseActionInteractive;
      case LidCloseAction.nothing:
        return l10n.lidCloseActionNothing;
      case LidCloseAction.logout:
        return l10n.lidCloseActionLogout;
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
