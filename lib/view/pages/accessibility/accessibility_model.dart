import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';

class AccessibilityModel extends ChangeNotifier {
  static const _schemaDesktopA11y = 'org.gnome.desktop.a11y';
  static const _schemaA11yApps = 'org.gnome.desktop.a11y.applications';
  static const _schemaA11yKeyboard = 'org.gnome.desktop.a11y.keyboard';
  static const _schemaA11yMouse = 'org.gnome.desktop.a11y.mouse';
  static const _schemaWmPreferences = 'org.gnome.desktop.wm.preferences';
  static const _schemaInterface = 'org.gnome.desktop.interface';
  static const _schemaPeripheralsKeyboard =
      'org.gnome.desktop.peripherals.keyboard';
  static const _schemaPeripheralsMouse =
      'org.gnome.settings-daemon.peripherals.mouse';
  static const _screenReaderKey = 'screen-reader-enabled';
  static const _universalAccessStatusKey =
      'always-show-universal-access-status';
  static const _visualBellKey = 'visual-bell';
  static const _visualBellTypeKey = 'visual-bell-type';
  static const _toggleKeysKey = 'togglekeys-enable';
  static const _screenKeyboardKey = 'screen-keyboard-enabled';
  static const _repeatKeyboardKey = 'repeat';
  static const _delayKeyboardKey = 'delay';
  static const _repeatIntervalKeyboardKey = 'repeat-interval';
  static const _mouseKeysKey = 'mousekeys-enable';
  static const _locatePointerKey = 'locate-pointer';
  static const _doubleClickDelayKey = 'double-click';
  static const _secondaryClickEnabledKey = 'secondary-click-enabled';
  static const _secondaryClickTimeKey = 'secondary-click-time';
  static const _dwellClickEnabledKey = 'dwell-click-enabled';
  static const _dwellTimeKey = 'dwell-time';
  static const _dwellThresholdKey = 'dwell-threshold';
  final _desktopA11Settings = GSettings(schemaId: _schemaDesktopA11y);
  final _a11yAppsSettings = GSettings(schemaId: _schemaA11yApps);
  final _a11yKeyboardSettings = GSettings(schemaId: _schemaA11yKeyboard);
  final _a11yMouseSettings = GSettings(schemaId: _schemaA11yMouse);
  final _wmPreferencesSettings = GSettings(schemaId: _schemaWmPreferences);
  final _interfaceSettings = GSettings(schemaId: _schemaInterface);
  final _peripheralsMouseSettings =
      GSettings(schemaId: _schemaPeripheralsMouse);
  final _peripheralsKeyboard = GSettings(schemaId: _schemaPeripheralsKeyboard);

  // Global section
  bool get getUniversalAccessStatus =>
      _desktopA11Settings.boolValue(_universalAccessStatusKey);

  void setUniversalAccessStatus(bool value) {
    _desktopA11Settings.setValue(_universalAccessStatusKey, value);
    notifyListeners();
  }

  // Seeing section
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

  // Hearing section
  bool get getVisualAlerts => _wmPreferencesSettings.boolValue(_visualBellKey);

  void setVisualAlerts(bool value) {
    _wmPreferencesSettings.setValue(_visualBellKey, value);
    notifyListeners();
  }

  String get getVisualAlertsType =>
      _wmPreferencesSettings.stringValue(_visualBellTypeKey);

  void setVisualAlertsType(String value) {
    _wmPreferencesSettings.setValue(_visualBellTypeKey, value);
    notifyListeners();
  }

  // Typing section
  bool get getScreenKeyboard => _a11yAppsSettings.boolValue(_screenKeyboardKey);

  void setScreenKeyboard(bool value) {
    _a11yAppsSettings.setValue(_screenKeyboardKey, value);
    notifyListeners();
  }

  bool get getKeyboardRepeat =>
      _peripheralsKeyboard.boolValue(_repeatKeyboardKey);

  void setKeyboardRepeat(bool value) {
    _peripheralsKeyboard.setValue(_repeatKeyboardKey, value);
    notifyListeners();
  }

  double get getDelay =>
      _peripheralsKeyboard.intValue(_delayKeyboardKey).toDouble();

  void setDelay(double value) {
    _peripheralsKeyboard.setValue(_delayKeyboardKey, value.toInt());
    notifyListeners();
  }

  double get getInterval =>
      _peripheralsKeyboard.intValue(_repeatIntervalKeyboardKey).toDouble();

  void setInterval(double value) {
    _peripheralsKeyboard.setValue(_repeatIntervalKeyboardKey, value.toInt());
    notifyListeners();
  }

  // Pointing & Clicking section
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
      _peripheralsMouseSettings.intValue(_doubleClickDelayKey).toDouble();

  void setDoubleClickDelay(double value) {
    _peripheralsMouseSettings.setValue(_doubleClickDelayKey, value.toInt());
    notifyListeners();
  }

  bool get getClickAssist => getSimulatedSecondaryClick || getDwellClick;

  bool get getSimulatedSecondaryClick =>
      _a11yMouseSettings.boolValue(_secondaryClickEnabledKey);

  void setSimulatedSecondaryClick(bool value) {
    _a11yMouseSettings.setValue(_secondaryClickEnabledKey, value);
    notifyListeners();
  }

  double get getSecondaryClickTime =>
      _a11yMouseSettings.doubleValue(_secondaryClickTimeKey);

  void setSecondaryClickTime(double value) {
    _a11yMouseSettings.setValue(_secondaryClickTimeKey, value);
    notifyListeners();
  }

  bool get getDwellClick => _a11yMouseSettings.boolValue(_dwellClickEnabledKey);

  void setDwellClick(bool value) {
    _a11yMouseSettings.setValue(_dwellClickEnabledKey, value);
    notifyListeners();
  }

  double get getDwellTime => _a11yMouseSettings.doubleValue(_dwellTimeKey);

  void setDwellTime(double value) {
    _a11yMouseSettings.setValue(_dwellTimeKey, value);
    notifyListeners();
  }

  double get getDwellThreshold =>
      _a11yMouseSettings.intValue(_dwellThresholdKey).toDouble();

  void setDwellThreshold(double value) {
    _a11yMouseSettings.setValue(_dwellThresholdKey, value.toInt());
    notifyListeners();
  }
}
