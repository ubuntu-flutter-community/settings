import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';

class AccessibilityModel extends ChangeNotifier {
  static const _schemaDesktopA11y = 'org.gnome.desktop.a11y';
  static const _schemaA11yApps = 'org.gnome.desktop.a11y.applications';
  static const _schemaA11yKeyboard = 'org.gnome.desktop.a11y.keyboard';
  static const _schemaWmPreferences = 'org.gnome.desktop.wm.preferences';
  static const _schemaInterface = 'org.gnome.desktop.interface';
  static const _schemaPeripheralsMouse =
      'org.gnome.settings-daemon.peripherals.mouse';
  static const _screenReaderKey = 'screen-reader-enabled';
  static const _universalAccessStatusKey =
      'always-show-universal-access-status';
  static const _visualBellKey = 'visual-bell';
  static const _visualBellTypeKey = 'visual-bell-type';
  static const _toggleKeysKey = 'togglekeys-enable';
  static const _screenKeyboardKey = 'screen-keyboard-enabled';
  static const _mouseKeysKey = 'mousekeys-enable';
  static const _locatePointerKey = 'locate-pointer';
  static const _doubleClickDelayKey = 'double-click';
  final _desktopA11Settings = GSettings(schemaId: _schemaDesktopA11y);
  final _a11yAppsSettings = GSettings(schemaId: _schemaA11yApps);
  final _a11yKeyboardSettings = GSettings(schemaId: _schemaA11yKeyboard);
  final _settings = GSettings(schemaId: _schemaWmPreferences);
  final _interfaceSettings = GSettings(schemaId: _schemaInterface);
  final _peripheralMouseSettings = GSettings(schemaId: _schemaPeripheralsMouse);

  bool get getUniversalAccessStatus =>
      _desktopA11Settings.boolValue(_universalAccessStatusKey);

  void setUniversalAccessStatus(bool value) {
    _desktopA11Settings.setValue(_universalAccessStatusKey, value);
    notifyListeners();
  }

  bool get getScreenReader => _a11yAppsSettings.boolValue(_screenReaderKey);

  void setScreenReader(bool value) {
    _a11yAppsSettings.setValue(_screenReaderKey, value);
    notifyListeners();
  }

  bool get getToggleKeys => _a11yKeyboardSettings.boolValue(_toggleKeysKey);

  void setToggleKeys(bool value) {
    _a11yKeyboardSettings.setValue(_toggleKeysKey, value);
    notifyListeners();
  }

  bool get getVisualAlerts => _settings.boolValue(_visualBellKey);

  void setVisualAlerts(bool value) {
    _settings.setValue(_visualBellKey, value);
    notifyListeners();
  }

  String get getVisualAlertsType => _settings.stringValue(_visualBellTypeKey);

  void setVisualAlertsType(String value) {
    _settings.setValue(_visualBellTypeKey, value);
    notifyListeners();
  }

  bool get getScreenKeyboard => _a11yAppsSettings.boolValue(_screenKeyboardKey);

  void setScreenKeyboard(bool value) {
    _a11yAppsSettings.setValue(_screenKeyboardKey, value);
    notifyListeners();
  }

  bool get getMouseKeys => _a11yKeyboardSettings.boolValue(_mouseKeysKey);

  void setMouseKeys(bool value) {
    _a11yKeyboardSettings.setValue(_mouseKeysKey, value);
    notifyListeners();
  }

  bool get getLocatePointer => _interfaceSettings.boolValue(_locatePointerKey);

  void setLocatePointer(bool value) {
    _interfaceSettings.setValue(_locatePointerKey, value);
    notifyListeners();
  }

  double get getDoubleClickDelay =>
      _peripheralMouseSettings.intValue(_doubleClickDelayKey).toDouble();

  void setDoubleClickDelay(double value) {
    _peripheralMouseSettings.setValue(_doubleClickDelayKey, value.toInt());
    notifyListeners();
  }
}
