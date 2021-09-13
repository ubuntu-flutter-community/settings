import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class AppearanceModel extends ChangeNotifier {
  static const _showTrashKey = 'show-trash';
  static const _dockFixedKey = 'dock-fixed';
  static const _extendHeightKey = 'extend-height';
  static const _backlitItemsKey = 'unity-backlit-items';
  static const _dashMaxIconSizeKey = 'dash-max-icon-size';
  static const _dockPositionKey = 'dock-position';
  static const _clickActionKey = 'click-action';

  final _dashToDockSettings = GSettingsSchema.lookup(schemaDashToDock) != null
      ? GSettings(schemaId: schemaDashToDock)
      : null;

  @override
  void dispose() {
    _dashToDockSettings?.dispose();
    super.dispose();
  }

  // Dock section

  bool? get getShowTrash => _dashToDockSettings?.boolValue(_showTrashKey);

  void setShowTrash(bool value) {
    _dashToDockSettings?.setValue(_showTrashKey, value);
    notifyListeners();
  }

  bool? get getAlwaysShowDock => _dashToDockSettings?.boolValue(_dockFixedKey);

  void setAlwaysShowDock(bool value) {
    _dashToDockSettings?.setValue(_dockFixedKey, value);
    notifyListeners();
  }

  bool? get getExtendDock => _dashToDockSettings?.boolValue(_extendHeightKey);

  void setExtendDock(bool value) {
    _dashToDockSettings?.setValue(_extendHeightKey, value);
    notifyListeners();
  }

  bool? get getAppGlow => _dashToDockSettings?.boolValue(_backlitItemsKey);

  void setAppGlow(bool value) {
    _dashToDockSettings?.setValue(_backlitItemsKey, value);
    notifyListeners();
  }

  double? get getMaxIconSize =>
      _dashToDockSettings?.intValue(_dashMaxIconSizeKey).toDouble();

  void setMaxIconSize(double value) {
    _dashToDockSettings?.setValue(_dashMaxIconSizeKey, value.toInt());
    notifyListeners();
  }

  static const _dockPositions = ['LEFT', 'RIGHT', 'BOTTOM'];

  String? get _getDockPosition =>
      _dashToDockSettings?.stringValue(_dockPositionKey);

  List<bool>? get getSelectedDockPositions {
    if (_getDockPosition != null) {
      return _dockPositions.map((value) => _getDockPosition == value).toList();
    }
  }

  void setDockPosition(int value) {
    _dashToDockSettings?.setValue(_dockPositionKey, _dockPositions[value]);
    notifyListeners();
  }

  static const _clickActions = ['minimize', 'focus-or-previews'];

  String? get _getClickAction =>
      _dashToDockSettings?.stringValue(_clickActionKey);

  List<bool>? get getSelectedClickActions {
    if (_getClickAction != null) {
      return _clickActions.map((value) => _getClickAction == value).toList();
    }
  }

  void setClickAction(int value) {
    _dashToDockSettings?.setValue(_clickActionKey, _clickActions[value]);
    notifyListeners();
  }
}
