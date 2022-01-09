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
  static const _customThemeShrink = 'custom-theme-shrink';

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

  static const dockPositions = ['LEFT', 'RIGHT', 'BOTTOM'];

  String? get _realDockPosition =>
      _dashToDockSettings?.stringValue(_dockPositionKey);

  String? get dockPosition =>
      dockPositions.contains(_realDockPosition) ? _realDockPosition : 'LEFT';

  set dockPosition(String? value) {
    if (value != null) {
      _dashToDockSettings!.setValue(_dockPositionKey, value);
      notifyListeners();
    }
  }

  static const clickActions = [
    'minimize',
    'focus-or-previews',
    'cycle-windows'
  ];

  String? get _realClickAction =>
      _dashToDockSettings?.stringValue(_clickActionKey);

  String? get clickAction => clickActions.contains(_realClickAction)
      ? _realClickAction
      : clickActions.first;

  set clickAction(String? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_clickActionKey, value);
      notifyListeners();
    }
  }

  // Currently this option is unstable and thus not exposed to the UI
  bool? get customThemeShrink =>
      _dashToDockSettings?.getValue(_customThemeShrink);

  set customThemeShrink(bool? value) {
    if (value != null) {
      _dashToDockSettings?.setValue(_customThemeShrink, value);
      notifyListeners();
    }
  }

  String getAutoHideAsset() {
    final _extendDock = extendDock ?? true;
    if (_extendDock == false) {
      if (dockPosition == 'RIGHT') {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-right.svg';
      }
      if (dockPosition == 'BOTTOM') {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-bottom.svg';
      } else {
        return 'assets/images/appearance/auto-hide-dock-mode/auto-hide-dock-left.svg';
      }
    }
    if (dockPosition == 'RIGHT') {
      return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-right.svg';
    }
    if (dockPosition == 'BOTTOM') {
      return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-bottom.svg';
    }
    return 'assets/images/appearance/auto-hide-panel-mode/auto-hide-panel-left.svg';
  }

  String getPanelModeAsset() {
    if (dockPosition == 'RIGHT') {
      return 'assets/images/appearance/panel-mode/panel-mode-right.svg';
    }
    if (dockPosition == 'BOTTOM') {
      return 'assets/images/appearance/panel-mode/panel-mode-bottom.svg';
    } else {
      return 'assets/images/appearance/panel-mode/panel-mode-left.svg';
    }
  }

  String getDockModeAsset() {
    if (dockPosition == 'RIGHT') {
      return 'assets/images/appearance/dock-mode/dock-mode-right.svg';
    }
    if (dockPosition == 'BOTTOM') {
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

  DockPosition getDockPosition() {
    if (dockPosition == 'RIGHT') {
      return DockPosition.right;
    }
    if (dockPosition == 'BOTTOM') {
      return DockPosition.bottom;
    } else {
      return DockPosition.left;
    }
  }

  void setDockPosition(DockPosition dockPosition) {
    _dashToDockSettings?.setValue(_dockPositionKey,
        dockPosition.toString().replaceAll('DockPosition.', '').toUpperCase());
    notifyListeners();
  }
}

enum DockPosition { left, bottom, right }
