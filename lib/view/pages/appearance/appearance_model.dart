import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
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
      : _dashToDockSettings = service.lookup(schemaDashToDock);

  final GSettings? _dashToDockSettings;

  // Dock section

  bool? get showTrash => _dashToDockSettings?.boolValue(_showTrashKey);

  void setShowTrash(bool value) {
    _dashToDockSettings?.setValue(_showTrashKey, value);
    notifyListeners();
  }

  bool? get alwaysShowDock => _dashToDockSettings?.boolValue(_dockFixedKey);

  void setAlwaysShowDock(bool value) {
    _dashToDockSettings?.setValue(_dockFixedKey, value);
    notifyListeners();
  }

  bool? get extendDock => _dashToDockSettings?.boolValue(_extendHeightKey);

  void setExtendDock(bool value) {
    _dashToDockSettings?.setValue(_extendHeightKey, value);
    notifyListeners();
  }

  bool? get appGlow => _dashToDockSettings?.boolValue(_backlitItemsKey);

  void setAppGlow(bool value) {
    _dashToDockSettings?.setValue(_backlitItemsKey, value);
    notifyListeners();
  }

  double? get maxIconSize =>
      _dashToDockSettings?.intValue(_dashMaxIconSizeKey).toDouble();

  void setMaxIconSize(double value) {
    var intValue = value.toInt();
    if (intValue.isOdd) {
      intValue -= 1;
    }
    _dashToDockSettings?.setValue(_dashMaxIconSizeKey, intValue);
    notifyListeners();
  }

  static const _dockPositions = ['LEFT', 'RIGHT', 'BOTTOM'];

  String? get _dockPosition =>
      _dashToDockSettings?.stringValue(_dockPositionKey);

  List<bool>? get selectedDockPositions {
    if (_dockPosition != null) {
      return _dockPositions.map((value) => _dockPosition == value).toList();
    }
  }

  void setDockPosition(int value) {
    _dashToDockSettings?.setValue(_dockPositionKey, _dockPositions[value]);
    notifyListeners();
  }

  static const _clickActions = ['minimize', 'focus-or-previews'];

  String? get _clickAction => _dashToDockSettings?.stringValue(_clickActionKey);

  List<bool>? get selectedClickActions {
    if (_clickAction != null) {
      return _clickActions.map((value) => _clickAction == value).toList();
    }
  }

  void setClickAction(int value) {
    _dashToDockSettings?.setValue(_clickActionKey, _clickActions[value]);
    notifyListeners();
  }
}
