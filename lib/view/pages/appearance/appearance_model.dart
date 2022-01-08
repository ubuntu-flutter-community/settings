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
}
