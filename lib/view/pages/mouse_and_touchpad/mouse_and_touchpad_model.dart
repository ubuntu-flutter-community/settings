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
      GSettingsSchema.lookup(schemaPeripheralsMouse) != null
          ? GSettings(schemaId: schemaPeripheralsMouse)
          : null;

  final _peripheralsTouchpadSettings =
      GSettingsSchema.lookup(schemaPeripheralTouchpad) != null
          ? GSettings(schemaId: schemaPeripheralTouchpad)
          : null;

  // Mouse section

  double? get getMouseSpeed =>
      _peripheralsMouseSettings?.doubleValue(_mouseSpeedKey);

  void setMouseSpeed(double value) {
    _peripheralsMouseSettings?.setValue(_mouseSpeedKey, value);
    notifyListeners();
  }

  bool? get getMouseNaturalScroll =>
      _peripheralsMouseSettings?.boolValue(_mouseNaturalScrollKey);

  void setMouseNaturalScroll(bool value) {
    _peripheralsMouseSettings?.setValue(_mouseNaturalScrollKey, value);
    notifyListeners();
  }

  // Touchpad section

  double? get getTouchpadSpeed =>
      _peripheralsTouchpadSettings?.doubleValue(_touchpadSpeedKey);

  void setTouchpadSpeed(double value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadSpeedKey, value);
    notifyListeners();
  }

  bool? get getTouchpadNaturalScroll =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadNaturalScrollKey);

  void setTouchpadNaturalScroll(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadNaturalScrollKey, value);
    notifyListeners();
  }

  bool? get getTouchpadTapToClick =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadTapToClickKey);

  void setTouchpadTapToClick(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadTapToClickKey, value);
    notifyListeners();
  }

  bool? get getTouchpadDisableWhileTyping =>
      _peripheralsTouchpadSettings?.boolValue(_touchpadDisableWhileTyping);

  void setTouchpadDisableWhileTyping(bool value) {
    _peripheralsTouchpadSettings?.setValue(_touchpadDisableWhileTyping, value);
    notifyListeners();
  }
}
