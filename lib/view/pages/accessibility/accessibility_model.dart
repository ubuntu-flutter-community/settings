import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';

class AccessibilityModel extends ChangeNotifier {
  static const _schemaDesktopA11y = 'org.gnome.desktop.a11y';
  static const _schemaA11yApps = 'org.gnome.desktop.a11y.applications';
  static const _schemaA11yKeyboard = 'org.gnome.desktop.a11y.keyboard';
  static const _schemaA11yMagnifier = 'org.gnome.desktop.a11y.magnifier';
  static const _schemaA11yMouse = 'org.gnome.desktop.a11y.mouse';
  static const _schemaWmPreferences = 'org.gnome.desktop.wm.preferences';
  static const _schemaInterface = 'org.gnome.desktop.interface';
  static const _schemaPeripheralsKeyboard =
      'org.gnome.desktop.peripherals.keyboard';
  static const _schemaPeripheralsMouse =
      'org.gnome.settings-daemon.peripherals.mouse';

  static const _gtkThemeKey = 'gtk-theme';
  static const _iconThemeKey = 'icon-theme';
  static const _textScalingFactorKey = 'text-scaling-factor';
  static const _cursorSizeKey = 'cursor-size';
  static const _zoomKey = 'screen-magnifier-enabled';
  static const _magFactorKey = 'mag-factor';
  static const _lensModeKey = 'lens-mode';
  static const _screenPositionKey = 'screen-position';
  static const _scrollAtEdgesKey = 'scroll-at-edges';
  static const _mouseTrackingKey = 'mouse-tracking';
  static const _crossHairsKey = 'show-cross-hairs';
  static const _crossHairsClipKey = 'cross-hairs-clip';
  static const _crossHairsThicknessKey = 'cross-hairs-thickness';
  static const _crossHairsLengthKey = 'cross-hairs-length';
  static const _inverseLightnessKey = 'invert-lightness';
  static const _brightnessRedKey = 'brightness-red';
  static const _brightnessGreenKey = 'brightness-green';
  static const _brightnessBlueKey = 'brightness-blue';
  static const _contrastRedKey = 'contrast-red';
  static const _contrastGreenKey = 'contrast-green';
  static const _contrastBlueKey = 'contrast-blue';
  static const _colorSaturationKey = 'color-saturation';
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
  static const _cursorBlinkKey = 'cursor-blink';
  static const _cursorBlinkTimeKey = 'cursor-blink-time';
  static const _enableA11yKeyboardKey = 'enable';
  static const _stickyKeysKey = 'stickykeys-enable';
  static const _stickyKeysTwoKeyOffKey = 'stickykeys-two-key-off';
  static const _stickyKeysModifierBeepKey = 'stickykeys-modifier-beep';
  static const _slowKeysKey = 'slowkeys-enable';
  static const _slowKeysDelayKey = 'slowkeys-delay';
  static const _slowKeysBeepPressKey = 'slowkeys-beep-press';
  static const _slowKeysBeepAcceptKey = 'slowkeys-beep-accept';
  static const _slowKeysBeepRejectKey = 'slowkeys-beep-reject';
  static const _bounceKeysKey = 'bouncekeys-enable';
  static const _bounceKeysDelayKey = 'bouncekeys-delay';
  static const _bounceKeysBeepRejectKey = 'bouncekeys-beep-reject';
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
  final _a11yMagnifierSettings = GSettings(schemaId: _schemaA11yMagnifier);
  final _a11yMouseSettings = GSettings(schemaId: _schemaA11yMouse);
  final _wmPreferencesSettings = GSettings(schemaId: _schemaWmPreferences);
  final _interfaceSettings = GSettings(schemaId: _schemaInterface);
  final _peripheralsMouseSettings =
      GSettings(schemaId: _schemaPeripheralsMouse);
  final _peripheralsKeyboardSettings =
      GSettings(schemaId: _schemaPeripheralsKeyboard);

  @override
  void dispose() {
    _desktopA11Settings.dispose();
    _a11yAppsSettings.dispose();
    _a11yKeyboardSettings.dispose();
    _a11yMagnifierSettings.dispose();
    _a11yMouseSettings.dispose();
    _wmPreferencesSettings.dispose();
    _interfaceSettings.dispose();
    _peripheralsMouseSettings.dispose();
    _peripheralsKeyboardSettings.dispose();
    super.dispose();
  } // Global section

  bool get getUniversalAccessStatus =>
      _desktopA11Settings.boolValue(_universalAccessStatusKey);

  void setUniversalAccessStatus(bool value) {
    _desktopA11Settings.setValue(_universalAccessStatusKey, value);
    notifyListeners();
  }

  // Seeing section

  static const _highContrastTheme = 'HighContrast';

  bool get getHighContrast =>
      _interfaceSettings.stringValue(_gtkThemeKey) == _highContrastTheme;

  void setHighContrast(bool value) {
    if (value) {
      _interfaceSettings.setValue(_gtkThemeKey, _highContrastTheme);
      _interfaceSettings.setValue(_iconThemeKey, _highContrastTheme);
    } else {
      _interfaceSettings.resetValue(_gtkThemeKey);
      _interfaceSettings.resetValue(_iconThemeKey);
    }
    notifyListeners();
  }

  double get _getTextScalingFactor =>
      _interfaceSettings.doubleValue(_textScalingFactorKey);

  bool get getLargeText => _getTextScalingFactor > 1.0;

  void setLargeText(bool value) {
    double factor = value ? 1.25 : 1.0;
    _interfaceSettings.setValue(_textScalingFactorKey, factor);
    notifyListeners();
  }

  int get getCursorSize => _interfaceSettings.intValue(_cursorSizeKey);

  String cursorSize() {
    String value = '';
    switch (getCursorSize) {
      case 24:
        value = 'Default';
        break;
      case 32:
        value = 'Medium';
        break;
      case 48:
        value = 'Large';
        break;
      case 64:
        value = 'Larger';
        break;
      case 96:
        value = 'Largest';
        break;
      default:
        value = '$getCursorSize pixels';
    }
    return value;
  }

  void setCursorSize(int value) {
    _interfaceSettings.setValue(_cursorSizeKey, value);
    notifyListeners();
  }

  bool get getZoom => _a11yAppsSettings.boolValue(_zoomKey);

  void setZoom(bool value) {
    _a11yAppsSettings.setValue(_zoomKey, value);
    notifyListeners();
  }

  double get getMagFactor => _a11yMagnifierSettings.doubleValue(_magFactorKey);

  void setMagFactor(double value) {
    _a11yMagnifierSettings.setValue(_magFactorKey, value);
    notifyListeners();
  }

  bool get getLensMode => _a11yMagnifierSettings.boolValue(_lensModeKey);

  void setLensMode(bool value) {
    _a11yMagnifierSettings.setValue(_lensModeKey, value);
    notifyListeners();
  }

  String get getScreenPosition =>
      _a11yMagnifierSettings.stringValue(_screenPositionKey);

  void setScreenPosition(String value) {
    _a11yMagnifierSettings.setValue(_screenPositionKey, value);
    notifyListeners();
  }

  bool get getScrollAtEdges =>
      _a11yMagnifierSettings.boolValue(_scrollAtEdgesKey);

  void setScrollAtEdges(bool value) {
    _a11yMagnifierSettings.setValue(_scrollAtEdgesKey, value);
    notifyListeners();
  }

  String get getMouseTracking =>
      _a11yMagnifierSettings.stringValue(_mouseTrackingKey);

  void setMouseTracking(String value) {
    _a11yMagnifierSettings.setValue(_mouseTrackingKey, value);
    notifyListeners();
  }

  bool get getCrossHairs => _a11yMagnifierSettings.boolValue(_crossHairsKey);

  void setCrossHairs(bool value) {
    _a11yMagnifierSettings.setValue(_crossHairsKey, value);
    notifyListeners();
  }

  bool get getCrossHairsClip =>
      !_a11yMagnifierSettings.boolValue(_crossHairsClipKey);

  void setCrossHairsClip(bool value) {
    _a11yMagnifierSettings.setValue(_crossHairsClipKey, !value);
    notifyListeners();
  }

  double get getCrossHairsThickness =>
      _a11yMagnifierSettings.intValue(_crossHairsThicknessKey).toDouble();

  void setCrossHairsThickness(double value) {
    _a11yMagnifierSettings.setValue(_crossHairsThicknessKey, value.toInt());
    notifyListeners();
  }

  double get getCrossHairsLength =>
      _a11yMagnifierSettings.intValue(_crossHairsLengthKey).toDouble();

  void setCrossHairsLength(double value) {
    _a11yMagnifierSettings.setValue(_crossHairsLengthKey, value.toInt());
    notifyListeners();
  }

  bool get getInverseLightness =>
      _a11yMagnifierSettings.boolValue(_inverseLightnessKey);

  void setInverseLightness(bool value) {
    _a11yMagnifierSettings.setValue(_inverseLightnessKey, value);
    notifyListeners();
  }

  double get getColorBrightness =>
      _a11yMagnifierSettings.doubleValue(_brightnessRedKey);

  void setColorBrightness(double value) {
    _a11yMagnifierSettings.setValue(_brightnessRedKey, value);
    _a11yMagnifierSettings.setValue(_brightnessGreenKey, value);
    _a11yMagnifierSettings.setValue(_brightnessBlueKey, value);
    notifyListeners();
  }

  double get getColorContrast =>
      _a11yMagnifierSettings.doubleValue(_contrastRedKey);

  void setColorContrast(double value) {
    _a11yMagnifierSettings.setValue(_contrastRedKey, value);
    _a11yMagnifierSettings.setValue(_contrastGreenKey, value);
    _a11yMagnifierSettings.setValue(_contrastBlueKey, value);
    notifyListeners();
  }

  double get getColorSaturation =>
      _a11yMagnifierSettings.doubleValue(_colorSaturationKey);

  void setColorSaturation(double value) {
    _a11yMagnifierSettings.setValue(_colorSaturationKey, value);
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
      _peripheralsKeyboardSettings.boolValue(_repeatKeyboardKey);

  void setKeyboardRepeat(bool value) {
    _peripheralsKeyboardSettings.setValue(_repeatKeyboardKey, value);
    notifyListeners();
  }

  double get getDelay =>
      _peripheralsKeyboardSettings.intValue(_delayKeyboardKey).toDouble();

  void setDelay(double value) {
    _peripheralsKeyboardSettings.setValue(_delayKeyboardKey, value.toInt());
    notifyListeners();
  }

  double get getInterval => _peripheralsKeyboardSettings
      .intValue(_repeatIntervalKeyboardKey)
      .toDouble();

  void setInterval(double value) {
    _peripheralsKeyboardSettings.setValue(
        _repeatIntervalKeyboardKey, value.toInt());
    notifyListeners();
  }

  bool get getCursorBlink => _interfaceSettings.boolValue(_cursorBlinkKey);

  void setCursorBlink(bool value) {
    _interfaceSettings.setValue(_cursorBlinkKey, value);
    notifyListeners();
  }

  double get getCursorBlinkTime =>
      _interfaceSettings.intValue(_cursorBlinkTimeKey).toDouble();

  void setCursorBlinkTime(double value) {
    _interfaceSettings.setValue(_cursorBlinkTimeKey, value.toInt());
    notifyListeners();
  }

  bool get getTypingAssist => getStickyKeys || getSlowKeys || getBounceKeys;

  String get getTypingAssistString => getTypingAssist ? 'On' : 'Off';

  bool get getKeyboardEnable =>
      _a11yKeyboardSettings.boolValue(_enableA11yKeyboardKey);

  void setKeyboardEnable(bool value) {
    _a11yKeyboardSettings.setValue(_enableA11yKeyboardKey, value);
    notifyListeners();
  }

  bool get getStickyKeys => _a11yKeyboardSettings.boolValue(_stickyKeysKey);

  void setStickyKeys(bool value) {
    _a11yKeyboardSettings.setValue(_stickyKeysKey, value);
    notifyListeners();
  }

  bool get getStickyKeysTwoKey =>
      _a11yKeyboardSettings.boolValue(_stickyKeysTwoKeyOffKey);

  void setStickyKeysTwoKey(bool value) {
    _a11yKeyboardSettings.setValue(_stickyKeysTwoKeyOffKey, value);
    notifyListeners();
  }

  bool get getStickyKeysBeep =>
      _a11yKeyboardSettings.boolValue(_stickyKeysModifierBeepKey);

  void setStickyKeysBeep(bool value) {
    _a11yKeyboardSettings.setValue(_stickyKeysModifierBeepKey, value);
    notifyListeners();
  }

  bool get getSlowKeys => _a11yKeyboardSettings.boolValue(_slowKeysKey);

  void setSlowKeys(bool value) {
    _a11yKeyboardSettings.setValue(_slowKeysKey, value);
    notifyListeners();
  }

  double get getSlowKeysDelay =>
      _a11yKeyboardSettings.intValue(_slowKeysDelayKey).toDouble();

  void setSlowKeysDelay(double value) {
    _a11yKeyboardSettings.setValue(_slowKeysDelayKey, value.toInt());
    notifyListeners();
  }

  bool get getSlowKeysBeepPress =>
      _a11yKeyboardSettings.boolValue(_slowKeysBeepPressKey);

  void setSlowKeysBeepPress(bool value) {
    _a11yKeyboardSettings.setValue(_slowKeysBeepPressKey, value);
    notifyListeners();
  }

  bool get getSlowKeysBeepAccept =>
      _a11yKeyboardSettings.boolValue(_slowKeysBeepAcceptKey);

  void setSlowKeysBeepAccept(bool value) {
    _a11yKeyboardSettings.setValue(_slowKeysBeepAcceptKey, value);
    notifyListeners();
  }

  bool get getSlowKeysBeepReject =>
      _a11yKeyboardSettings.boolValue(_slowKeysBeepRejectKey);

  void setSlowKeysBeepReject(bool value) {
    _a11yKeyboardSettings.setValue(_slowKeysBeepRejectKey, value);
    notifyListeners();
  }

  bool get getBounceKeys => _a11yKeyboardSettings.boolValue(_bounceKeysKey);

  void setBounceKeys(bool value) {
    _a11yKeyboardSettings.setValue(_bounceKeysKey, value);
    notifyListeners();
  }

  double get getBounceKeysDelay =>
      _a11yKeyboardSettings.intValue(_bounceKeysDelayKey).toDouble();

  void setBounceKeysDelay(double value) {
    _a11yKeyboardSettings.setValue(_bounceKeysDelayKey, value.toInt());
    notifyListeners();
  }

  bool get getBounceKeysBeepReject =>
      _a11yKeyboardSettings.boolValue(_bounceKeysBeepRejectKey);

  void setBounceKeysBeepReject(bool value) {
    _a11yKeyboardSettings.setValue(_bounceKeysBeepRejectKey, value);
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

  String get getClickAssistString => getClickAssist ? 'On' : 'Off';

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
