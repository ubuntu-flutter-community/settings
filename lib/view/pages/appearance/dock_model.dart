import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/utils.dart';

class DockModel extends SafeChangeNotifier {
  DockModel(SettingsService service)
      : _dashToDockSettings = service.lookup(schemaDashToDock) {
    _dashToDockSettings?.addListener(notifyListeners);
  }
  static const _showTrashKey = 'show-trash';
  static const _dockFixedKey = 'dock-fixed';
  static const _extendHeightKey = 'extend-height';
  static const _backlitItemsKey = 'unity-backlit-items';
  static const _dashMaxIconSizeKey = 'dash-max-icon-size';
  static const _dockPositionKey = 'dock-position';
  static const _clickActionKey = 'click-action';

  @override
  void dispose() {
    _dashToDockSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _dashToDockSettings;

  // Dock section

  bool? get showTrash => _dashToDockSettings?.boolValue(_showTrashKey);

  set showTrash(bool? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_showTrashKey, value);
      notifyListeners();
    }
  }

  bool? get alwaysShowDock => _dashToDockSettings?.boolValue(_dockFixedKey);

  set alwaysShowDock(bool? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_dockFixedKey, value);
      notifyListeners();
    }
  }

  bool? get extendDock => _dashToDockSettings?.boolValue(_extendHeightKey);

  set extendDock(bool? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_extendHeightKey, value);
      notifyListeners();
    }
  }

  bool? get appGlow => _dashToDockSettings?.boolValue(_backlitItemsKey);

  set appGlow(bool? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_backlitItemsKey, value);
      notifyListeners();
    }
  }

  double? get maxIconSize =>
      _dashToDockSettings?.intValue(_dashMaxIconSizeKey)?.toDouble();

  set maxIconSize(double? value) {
    if (value != null) {
      var intValue = value.toInt();
      if (intValue.isOdd) {
        intValue -= 1;
      }
      _dashToDockSettings?.setValue(_dashMaxIconSizeKey, intValue);
      notifyListeners();
    }
  }

  DockPosition? get dockPosition {
    final positionString = _dashToDockSettings?.stringValue(_dockPositionKey);
    switch (positionString) {
      case 'LEFT':
        return DockPosition.left;
      case 'RIGHT':
        return DockPosition.right;
      case 'BOTTOM':
        return DockPosition.bottom;
      default:
        return null;
    }
  }

  set dockPosition(DockPosition? dockPosition) {
    if (dockPosition != null) {
      _dashToDockSettings?.setValue(
        _dockPositionKey,
        dockPosition.name.toUpperCase(),
      );
      notifyListeners();
    }
  }

  DockClickAction? get clickAction {
    final clickActionString = _dashToDockSettings?.stringValue(_clickActionKey);
    switch (clickActionString) {
      case 'minimize':
        return DockClickAction.minimize;
      case 'focus-or-previews':
        return DockClickAction.focusOrPreviews;
      case 'cycle-windows':
        return DockClickAction.cycleWindows;
      default:
        return null;
    }
  }

  set clickAction(DockClickAction? value) {
    if (value != null) {
      final newString = camelCaseToSplitByDash(value.name);
      _dashToDockSettings?.setValue(_clickActionKey, newString);
      notifyListeners();
    }
  }

  String getAutoHideAsset() {
    if (extendDock == false) {
      if (dockPosition == DockPosition.right) {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-right.svg';
      }
      if (dockPosition == DockPosition.bottom) {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-bottom.svg';
      } else {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-left.svg';
      }
    }
    if (dockPosition == DockPosition.right) {
      return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-right.svg';
    }
    if (dockPosition == DockPosition.bottom) {
      return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-bottom.svg';
    }
    return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-left.svg';
  }

  String getPanelModeAsset() {
    if (dockPosition == DockPosition.right) {
      return 'assets/images/appearance/panel-mode/panel-mode-right.svg';
    }
    if (dockPosition == DockPosition.bottom) {
      return 'assets/images/appearance/panel-mode/panel-mode-bottom.svg';
    } else {
      return 'assets/images/appearance/panel-mode/panel-mode-left.svg';
    }
  }

  String getDockModeAsset() {
    if (dockPosition == DockPosition.right) {
      return 'assets/images/appearance/dock-mode/dock-mode-right.svg';
    }
    if (dockPosition == DockPosition.bottom) {
      return 'assets/images/appearance/dock-mode/dock-mode-bottom.svg';
    } else {
      return 'assets/images/appearance/dock-mode/dock-mode-left.svg';
    }
  }

  String getDockPositionAsset() {
    if (extendDock == false) {
      return getDockModeAsset();
    }
    return getPanelModeAsset();
  }

  String getRightSideAsset() {
    if (extendDock == true) {
      return 'assets/images/appearance/panel-mode/panel-mode-right.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-right.svg';
  }

  String getLeftSideAsset() {
    if (extendDock == true) {
      return 'assets/images/appearance/panel-mode/panel-mode-left.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-left.svg';
  }

  String getBottomAsset() {
    if (extendDock == true) {
      return 'assets/images/appearance/panel-mode/panel-mode-bottom.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-bottom.svg';
  }
}

enum DockPosition {
  left,
  bottom,
  right;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case DockPosition.left:
        return l10n.dockPositionLeft;
      case DockPosition.bottom:
        return l10n.dockPositionBottom;
      case DockPosition.right:
        return l10n.dockPositionRight;
    }
  }
}

enum DockClickAction {
  minimize,
  cycleWindows,
  focusOrPreviews;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case DockClickAction.minimize:
        return l10n.dockClickActionMinimize;
      case DockClickAction.cycleWindows:
        return l10n.dockClickActionCycleWindows;
      case DockClickAction.focusOrPreviews:
        return l10n.dockClickActionFocusOrPreviews;
    }
  }
}
