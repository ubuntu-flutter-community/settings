import 'package:flutter/foundation.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class AppearanceModel extends ChangeNotifier {
  static const _showTrashKey = 'show-trash';
  static const _dockFixedKey = 'dock-fixed';
  static const _extendHeightKey = 'extend-height';
  static const _backlitItemsKey = 'unity-backlit-items';
  static const _dashMaxIconSizeKey = 'dash-max-icon-size';
  static const _dockPositionKey = 'dock-position';
  static const _clickActionKey = 'click-action';

  AppearanceModel(SettingsService service)
      : _dashToDockSettings = service.lookup(schemaDashToDock) {
    _dashToDockSettings?.addListener(notifyListeners);
  }

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
    var positionString = _dashToDockSettings?.stringValue(_dockPositionKey);
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
          _dockPositionKey, dockPosition.name.toUpperCase());
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
      String newString = camelCaseToSplitByDash(value.name);
      _dashToDockSettings?.setValue(_clickActionKey, newString);
      notifyListeners();
    }
  }

  String getAutoHideAsset() {
    final _extendDock = extendDock ?? true;
    if (_extendDock == false) {
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
    final _extendDock = extendDock ?? true;
    if (!_extendDock) {
      return getDockModeAsset();
    }
    return getPanelModeAsset();
  }

  String getRightSideAsset() {
    final _extendDock = extendDock ?? true;
    if (_extendDock) {
      return 'assets/images/appearance/panel-mode/panel-mode-right.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-right.svg';
  }

  String getLeftSideAsset() {
    final _extendDock = extendDock ?? true;
    if (_extendDock) {
      return 'assets/images/appearance/panel-mode/panel-mode-left.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-left.svg';
  }

  String getBottomAsset() {
    final _extendDock = extendDock ?? true;
    if (_extendDock) {
      return 'assets/images/appearance/panel-mode/panel-mode-bottom.svg';
    }
    return 'assets/images/appearance/dock-mode/dock-mode-bottom.svg';
  }
}

enum DockPosition { left, bottom, right }

enum DockClickAction { minimize, cycleWindows, focusOrPreviews }

String camelCaseToSplitByDash(String value) {
  final beforeCapitalLetterRegex = RegExp(r"(?=[A-Z])");
  final parts = value.split(beforeCapitalLetterRegex);
  var newString = '';
  for (var part in parts) {
    if (newString.isEmpty) {
      newString = part.toLowerCase();
    } else {
      newString = newString.toLowerCase() + '-' + part.toLowerCase();
    }
  }
  return newString;
}
