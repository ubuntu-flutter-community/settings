import 'package:flutter/foundation.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/utils.dart';

class AccessibilityModel extends ChangeNotifier {

  AccessibilityModel(SettingsService service)
      : _desktopA11Settings = service.lookup(schemaDesktopA11y),
        _a11yAppsSettings = service.lookup(schemaA11yApps),
        _a11yKeyboardSettings = service.lookup(schemaA11yKeyboard),
        _a11yMagnifierSettings = service.lookup(schemaA11yMagnifier),
        _a11yMouseSettings = service.lookup(schemaA11yMouse),
        _wmPreferencesSettings = service.lookup(schemaWmPreferences),
        _interfaceSettings = service.lookup(schemaInterface),
        _peripheralsMouseSettings = service.lookup(schemaPeripheralsMouse),
        _peripheralsKeyboardSettings =
            service.lookup(schemaPeripheralsKeyboard) {
    _desktopA11Settings?.addListener(notifyListeners);
    _a11yAppsSettings?.addListener(notifyListeners);
    _a11yKeyboardSettings?.addListener(notifyListeners);
    _a11yMagnifierSettings?.addListener(notifyListeners);
    _a11yMouseSettings?.addListener(notifyListeners);
    _wmPreferencesSettings?.addListener(notifyListeners);
    _interfaceSettings?.addListener(notifyListeners);
    _peripheralsMouseSettings?.addListener(notifyListeners);
    _peripheralsKeyboardSettings?.addListener(notifyListeners);
  }
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
  static const _crossHairsColor = 'cross-hairs-color';
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

  @override
  void dispose() {
    _desktopA11Settings?.removeListener(notifyListeners);
    _a11yAppsSettings?.removeListener(notifyListeners);
    _a11yKeyboardSettings?.removeListener(notifyListeners);
    _a11yMagnifierSettings?.removeListener(notifyListeners);
    _a11yMouseSettings?.removeListener(notifyListeners);
    _wmPreferencesSettings?.removeListener(notifyListeners);
    _interfaceSettings?.removeListener(notifyListeners);
    _peripheralsMouseSettings?.removeListener(notifyListeners);
    _peripheralsKeyboardSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _desktopA11Settings;
  final Settings? _a11yAppsSettings;
  final Settings? _a11yKeyboardSettings;
  final Settings? _a11yMagnifierSettings;
  final Settings? _a11yMouseSettings;
  final Settings? _wmPreferencesSettings;
  final Settings? _interfaceSettings;
  final Settings? _peripheralsMouseSettings;
  final Settings? _peripheralsKeyboardSettings;

  // Global section

  bool? get universalAccessStatus =>
      _desktopA11Settings?.boolValue(_universalAccessStatusKey);

  void setUniversalAccessStatus(bool value) {
    _desktopA11Settings?.setValue(_universalAccessStatusKey, value);
    notifyListeners();
  }

  // Seeing section

  static const _highContrastTheme = 'HighContrast';

  bool? get highContrast =>
      _interfaceSettings?.stringValue(_gtkThemeKey) == _highContrastTheme;

  void setHighContrast(bool value) {
    if (value) {
      _interfaceSettings?.setValue(_gtkThemeKey, _highContrastTheme);
      _interfaceSettings?.setValue(_iconThemeKey, _highContrastTheme);
    } else {
      _interfaceSettings?.resetValue(_gtkThemeKey);
      _interfaceSettings?.resetValue(_iconThemeKey);
    }
    notifyListeners();
  }

  double? get _textScalingFactor =>
      _interfaceSettings?.doubleValue(_textScalingFactorKey);

  bool get largeText => _textScalingFactor != null && _textScalingFactor! > 1.0;

  void setLargeText(bool value) {
    final factor = value ? 1.25 : 1.0;
    _interfaceSettings?.setValue(_textScalingFactorKey, factor);
    notifyListeners();
  }

  CursorSize? get cursorSize {
    final cursorSizeValue = _interfaceSettings?.intValue(_cursorSizeKey);

    switch (cursorSizeValue) {
      case 24:
        return CursorSize.normal;
      case 32:
        return CursorSize.medium;
      case 48:
        return CursorSize.large;
      case 64:
        return CursorSize.larger;
      case 96:
        return CursorSize.largest;
      default:
        return null;
    }
  }

  set cursorSize(CursorSize? cursorSize) {
    switch (cursorSize) {
      case CursorSize.normal:
        _interfaceSettings?.setValue(_cursorSizeKey, 24);
        break;
      case CursorSize.medium:
        _interfaceSettings?.setValue(_cursorSizeKey, 32);
        break;
      case CursorSize.large:
        _interfaceSettings?.setValue(_cursorSizeKey, 48);
        break;
      case CursorSize.larger:
        _interfaceSettings?.setValue(_cursorSizeKey, 64);
        break;
      case CursorSize.largest:
        _interfaceSettings?.setValue(_cursorSizeKey, 96);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  bool? get zoom => _a11yAppsSettings?.boolValue(_zoomKey);

  void setZoom(bool value) {
    _a11yAppsSettings?.setValue(_zoomKey, value);
    notifyListeners();
  }

  double? get magFactor => _a11yMagnifierSettings?.doubleValue(_magFactorKey);

  void setMagFactor(double value) {
    _a11yMagnifierSettings?.setValue(_magFactorKey, value);
    notifyListeners();
  }

  bool? get lensMode => _a11yMagnifierSettings?.boolValue(_lensModeKey);

  bool get screenPartEnabled => lensMode != null && !lensMode!;

  void setLensMode(bool value) {
    _a11yMagnifierSettings?.setValue(_lensModeKey, value);
    notifyListeners();
  }

  ScreenPosition? get screenPosition {
    final positionString =
        _a11yMagnifierSettings?.stringValue(_screenPositionKey);
    switch (positionString) {
      case 'full-screen':
        return ScreenPosition.fullScreen;
      case 'top-half':
        return ScreenPosition.topHalf;
      case 'bottom-half':
        return ScreenPosition.bottomHalf;
      case 'left-half':
        return ScreenPosition.leftHalf;
      case 'right-half':
        return ScreenPosition.rightHalf;
      default:
        return null;
    }
  }

  set screenPosition(ScreenPosition? screenPosition) {
    if (screenPosition != null) {
      final value = camelCaseToSplitByDash(screenPosition.name);
      _a11yMagnifierSettings?.setValue(_screenPositionKey, value);
      notifyListeners();
    }
  }

  bool? get scrollAtEdges =>
      _a11yMagnifierSettings?.boolValue(_scrollAtEdgesKey);

  void setScrollAtEdges(bool value) {
    _a11yMagnifierSettings?.setValue(_scrollAtEdgesKey, value);
    notifyListeners();
  }

  String? get mouseTracking =>
      _a11yMagnifierSettings?.stringValue(_mouseTrackingKey);

  void setMouseTracking(String value) {
    _a11yMagnifierSettings?.setValue(_mouseTrackingKey, value);
    notifyListeners();
  }

  bool? get crossHairs => _a11yMagnifierSettings?.boolValue(_crossHairsKey);

  void setCrossHairs(bool value) {
    _a11yMagnifierSettings?.setValue(_crossHairsKey, value);
    notifyListeners();
  }

  bool? get crossHairsClip {
    return _a11yMagnifierSettings?.boolValue(_crossHairsClipKey) == false;
  }

  void setCrossHairsClip(bool value) {
    _a11yMagnifierSettings?.setValue(_crossHairsClipKey, !value);
    notifyListeners();
  }

  double? get crossHairsThickness =>
      _a11yMagnifierSettings?.intValue(_crossHairsThicknessKey)?.toDouble();

  void setCrossHairsThickness(double value) {
    _a11yMagnifierSettings?.setValue(_crossHairsThicknessKey, value.toInt());
    notifyListeners();
  }

  double? get crossHairsLength =>
      _a11yMagnifierSettings?.intValue(_crossHairsLengthKey)?.toDouble();

  void setCrossHairsLength(double value) {
    _a11yMagnifierSettings?.setValue(_crossHairsLengthKey, value.toInt());
    notifyListeners();
  }

  String? get crossHairsColor =>
      _a11yMagnifierSettings?.stringValue(_crossHairsColor);

  void setCrossHairsColor(String value) {
    _a11yMagnifierSettings?.setValue(_crossHairsColor, value);
    notifyListeners();
  }

  bool? get inverseLightness =>
      _a11yMagnifierSettings?.boolValue(_inverseLightnessKey);

  void setInverseLightness(bool value) {
    _a11yMagnifierSettings?.setValue(_inverseLightnessKey, value);
    notifyListeners();
  }

  double? get colorBrightness =>
      _a11yMagnifierSettings?.doubleValue(_brightnessRedKey);

  void setColorBrightness(double value) {
    _a11yMagnifierSettings?.setValue(_brightnessRedKey, value);
    _a11yMagnifierSettings?.setValue(_brightnessGreenKey, value);
    _a11yMagnifierSettings?.setValue(_brightnessBlueKey, value);
    notifyListeners();
  }

  double? get colorContrast =>
      _a11yMagnifierSettings?.doubleValue(_contrastRedKey);

  void setColorContrast(double value) {
    _a11yMagnifierSettings?.setValue(_contrastRedKey, value);
    _a11yMagnifierSettings?.setValue(_contrastGreenKey, value);
    _a11yMagnifierSettings?.setValue(_contrastBlueKey, value);
    notifyListeners();
  }

  double? get colorSaturation =>
      _a11yMagnifierSettings?.doubleValue(_colorSaturationKey);

  void setColorSaturation(double value) {
    _a11yMagnifierSettings?.setValue(_colorSaturationKey, value);
    notifyListeners();
  }

  bool? get screenReader => _a11yAppsSettings?.boolValue(_screenReaderKey);

  void setScreenReader(bool value) {
    _a11yAppsSettings?.setValue(_screenReaderKey, value);
    notifyListeners();
  }

  bool? get toggleKeys => _a11yKeyboardSettings?.boolValue(_toggleKeysKey);

  void setToggleKeys(bool value) {
    _a11yKeyboardSettings?.setValue(_toggleKeysKey, value);
    notifyListeners();
  }

  // Hearing section
  bool? get visualAlerts => _wmPreferencesSettings?.boolValue(_visualBellKey);

  void setVisualAlerts(bool value) {
    _wmPreferencesSettings?.setValue(_visualBellKey, value);
    notifyListeners();
  }

  String? get visualAlertsType =>
      _wmPreferencesSettings?.stringValue(_visualBellTypeKey);

  void setVisualAlertsType(String value) {
    _wmPreferencesSettings?.setValue(_visualBellTypeKey, value);
    notifyListeners();
  }

  // Typing section
  bool? get screenKeyboard => _a11yAppsSettings?.boolValue(_screenKeyboardKey);

  void setScreenKeyboard(bool value) {
    _a11yAppsSettings?.setValue(_screenKeyboardKey, value);
    notifyListeners();
  }

  bool? get keyboardRepeat =>
      _peripheralsKeyboardSettings?.boolValue(_repeatKeyboardKey);

  void setKeyboardRepeat(bool value) {
    _peripheralsKeyboardSettings?.setValue(_repeatKeyboardKey, value);
    notifyListeners();
  }

  double? get delay =>
      _peripheralsKeyboardSettings?.intValue(_delayKeyboardKey)?.toDouble();

  void setDelay(double value) {
    _peripheralsKeyboardSettings?.setUint32Value(
      _delayKeyboardKey,
      value.toInt(),
    );
    notifyListeners();
  }

  double? get interval => _peripheralsKeyboardSettings
      ?.intValue(_repeatIntervalKeyboardKey)
      ?.toDouble();

  void setInterval(double value) {
    _peripheralsKeyboardSettings?.setUint32Value(
      _repeatIntervalKeyboardKey,
      value.toInt(),
    );
    notifyListeners();
  }

  bool? get cursorBlink => _interfaceSettings?.boolValue(_cursorBlinkKey);

  void setCursorBlink(bool value) {
    _interfaceSettings?.setValue(_cursorBlinkKey, value);
    notifyListeners();
  }

  double? get cursorBlinkTime =>
      _interfaceSettings?.intValue(_cursorBlinkTimeKey)?.toDouble();

  void setCursorBlinkTime(double value) {
    _interfaceSettings?.setValue(_cursorBlinkTimeKey, value.toInt());
    notifyListeners();
  }

  bool get typingAssistAvailable =>
      stickyKeys != null || slowKeys != null || bounceKeys != null;

  bool get _typingAssist =>
      (stickyKeys ?? false) || (slowKeys ?? false) || (bounceKeys ?? false);

  String get typingAssistString => _typingAssist ? 'On' : 'Off';

  bool? get keyboardEnable =>
      _a11yKeyboardSettings?.boolValue(_enableA11yKeyboardKey);

  void setKeyboardEnable(bool value) {
    _a11yKeyboardSettings?.setValue(_enableA11yKeyboardKey, value);
    notifyListeners();
  }

  bool? get stickyKeys => _a11yKeyboardSettings?.boolValue(_stickyKeysKey);

  void setStickyKeys(bool value) {
    _a11yKeyboardSettings?.setValue(_stickyKeysKey, value);
    notifyListeners();
  }

  bool? get stickyKeysTwoKey =>
      _a11yKeyboardSettings?.boolValue(_stickyKeysTwoKeyOffKey);

  void setStickyKeysTwoKey(bool value) {
    _a11yKeyboardSettings?.setValue(_stickyKeysTwoKeyOffKey, value);
    notifyListeners();
  }

  bool? get stickyKeysBeep =>
      _a11yKeyboardSettings?.boolValue(_stickyKeysModifierBeepKey);

  void setStickyKeysBeep(bool value) {
    _a11yKeyboardSettings?.setValue(_stickyKeysModifierBeepKey, value);
    notifyListeners();
  }

  bool? get slowKeys => _a11yKeyboardSettings?.boolValue(_slowKeysKey);

  void setSlowKeys(bool value) {
    _a11yKeyboardSettings?.setValue(_slowKeysKey, value);
    notifyListeners();
  }

  double? get slowKeysDelay =>
      _a11yKeyboardSettings?.intValue(_slowKeysDelayKey)?.toDouble();

  void setSlowKeysDelay(double value) {
    _a11yKeyboardSettings?.setValue(_slowKeysDelayKey, value.toInt());
    notifyListeners();
  }

  bool? get slowKeysBeepPress =>
      _a11yKeyboardSettings?.boolValue(_slowKeysBeepPressKey);

  void setSlowKeysBeepPress(bool value) {
    _a11yKeyboardSettings?.setValue(_slowKeysBeepPressKey, value);
    notifyListeners();
  }

  bool? get slowKeysBeepAccept =>
      _a11yKeyboardSettings?.boolValue(_slowKeysBeepAcceptKey);

  void setSlowKeysBeepAccept(bool value) {
    _a11yKeyboardSettings?.setValue(_slowKeysBeepAcceptKey, value);
    notifyListeners();
  }

  bool? get slowKeysBeepReject =>
      _a11yKeyboardSettings?.boolValue(_slowKeysBeepRejectKey);

  void setSlowKeysBeepReject(bool value) {
    _a11yKeyboardSettings?.setValue(_slowKeysBeepRejectKey, value);
    notifyListeners();
  }

  bool? get bounceKeys => _a11yKeyboardSettings?.boolValue(_bounceKeysKey);

  void setBounceKeys(bool value) {
    _a11yKeyboardSettings?.setValue(_bounceKeysKey, value);
    notifyListeners();
  }

  double? get bounceKeysDelay =>
      _a11yKeyboardSettings?.intValue(_bounceKeysDelayKey)?.toDouble();

  void setBounceKeysDelay(double value) {
    _a11yKeyboardSettings?.setValue(_bounceKeysDelayKey, value.toInt());
    notifyListeners();
  }

  bool? get bounceKeysBeepReject =>
      _a11yKeyboardSettings?.boolValue(_bounceKeysBeepRejectKey);

  void setBounceKeysBeepReject(bool value) {
    _a11yKeyboardSettings?.setValue(_bounceKeysBeepRejectKey, value);
    notifyListeners();
  }

  // Pointing & Clicking section
  bool? get mouseKeys => _a11yKeyboardSettings?.boolValue(_mouseKeysKey);

  void setMouseKeys(bool value) {
    _a11yKeyboardSettings?.setValue(_mouseKeysKey, value);
    notifyListeners();
  }

  bool? get locatePointer => _interfaceSettings?.boolValue(_locatePointerKey);

  void setLocatePointer(bool value) {
    _interfaceSettings?.setValue(_locatePointerKey, value);
    notifyListeners();
  }

  double? get doubleClickDelay =>
      _peripheralsMouseSettings?.intValue(_doubleClickDelayKey)?.toDouble();

  void setDoubleClickDelay(double value) {
    _peripheralsMouseSettings?.setValue(_doubleClickDelayKey, value.toInt());
    notifyListeners();
  }

  bool get clickAssistAvailable =>
      simulatedSecondaryClick != null || dwellClick != null;

  bool get _clickAssist =>
      (simulatedSecondaryClick ?? false) || (dwellClick ?? false);

  String get clickAssistString => _clickAssist ? 'On' : 'Off';

  bool? get simulatedSecondaryClick =>
      _a11yMouseSettings?.boolValue(_secondaryClickEnabledKey);

  void setSimulatedSecondaryClick(bool value) {
    _a11yMouseSettings?.setValue(_secondaryClickEnabledKey, value);
    notifyListeners();
  }

  double? get secondaryClickTime =>
      _a11yMouseSettings?.doubleValue(_secondaryClickTimeKey);

  void setSecondaryClickTime(double value) {
    _a11yMouseSettings?.setValue(_secondaryClickTimeKey, value);
    notifyListeners();
  }

  bool? get dwellClick => _a11yMouseSettings?.boolValue(_dwellClickEnabledKey);

  void setDwellClick(bool value) {
    _a11yMouseSettings?.setValue(_dwellClickEnabledKey, value);
    notifyListeners();
  }

  double? get dwellTime => _a11yMouseSettings?.doubleValue(_dwellTimeKey);

  void setDwellTime(double value) {
    _a11yMouseSettings?.setValue(_dwellTimeKey, value);
    notifyListeners();
  }

  double? get dwellThreshold =>
      _a11yMouseSettings?.intValue(_dwellThresholdKey)?.toDouble();

  void setDwellThreshold(double value) {
    _a11yMouseSettings?.setValue(_dwellThresholdKey, value.toInt());
    notifyListeners();
  }
}

enum CursorSize {
  normal,
  medium,
  large,
  larger,
  largest;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case CursorSize.normal:
        return l10n.cursorSizeDefault;
      case CursorSize.medium:
        return l10n.cursorSizeMedium;
      case CursorSize.large:
        return l10n.cursorSizeLarge;
      case CursorSize.larger:
        return l10n.cursorSizeLarger;
      case CursorSize.largest:
        return l10n.cursorSizeLargest;
    }
  }
}

enum ScreenPosition {
  fullScreen,
  topHalf,
  bottomHalf,
  leftHalf,
  rightHalf;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case ScreenPosition.fullScreen:
        return l10n.screenPositionFullScreen;
      case ScreenPosition.topHalf:
        return l10n.screenPositionTopHalf;
      case ScreenPosition.bottomHalf:
        return l10n.screenPositionBottomHalf;
      case ScreenPosition.leftHalf:
        return l10n.screenPositionLeftHalf;
      case ScreenPosition.rightHalf:
        return l10n.screenPositionRightHalf;
    }
  }
}
