import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class MouseAndTouchpadModel extends ChangeNotifier {
  static const _mouseSpeedKey = 'speed';
  static const _mouseNaturalScrollKey = 'natural-scroll';
  static const _touchpadSpeedKey = 'speed';
  static const _touchpadNaturalScrollKey = 'natural-scroll';
  static const _touchpadTapToClickKey = 'tap-to-click';
  static const _touchpadDisableWhileTyping = 'disable-while-typing';

  final _peripheralsMouseSettings =
      GSettingsSchema.lookup(schemaDesktopPeripheralsMouse) != null
          ? GSettings(schemaId: schemaDesktopPeripheralsMouse)
          : null;

  final _peripheralsTouchpadSettings =
      GSettingsSchema.lookup(schemaPeripheralTouchpad) != null
          ? GSettings(schemaId: schemaPeripheralTouchpad)
          : null;

  @override
  void dispose() {
    _peripheralsMouseSettings?.dispose();
    _peripheralsTouchpadSettings?.dispose();
    super.dispose();
  }

  // Mouse section

  double? get mouseSpeed =>
      _peripheralsMouseSettings?.doubleValue(_mouseSpeedKey);

  void setMouseSpeed(double value) {
    _peripheralsMouseSettings?.setValue(_mouseSpeedKey, value);
    notifyListeners();
  }

  bool? get mouseNaturalScroll =>
      _peripheralsMouseSettings?.boolValue(_mouseNaturalScrollKey);

  void setMouseNaturalScroll(bool value) {
    _peripheralsMouseSettings?.setValue(_mouseNaturalScrollKey, value);
    notifyListeners();
  }

  // Touchpad section

  double? get touchpadSpeed =>
      _peripheralsTouchpadSettings?.doubleValue(_touchpadSpeedKey);

  void setTouchpadSpeed(double value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadSpeedKey, value);
    notifyListeners();
  }

  bool? get touchpadNaturalScroll =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadNaturalScrollKey);

  void setTouchpadNaturalScroll(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadNaturalScrollKey, value);
    notifyListeners();
  }

  bool? get touchpadTapToClick =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadTapToClickKey);

  void setTouchpadTapToClick(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadTapToClickKey, value);
    notifyListeners();
  }

  bool? get touchpadDisableWhileTyping =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadDisableWhileTyping);

  void setTouchpadDisableWhileTyping(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadDisableWhileTyping, value);
    notifyListeners();
  }
}
