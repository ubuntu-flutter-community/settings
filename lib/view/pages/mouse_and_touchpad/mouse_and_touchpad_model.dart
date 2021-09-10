import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class MouseAndTouchpadModel extends ChangeNotifier {
  static const _mouseSpeedKey = 'speed';
  static const _mouseNaturalScrollKey = 'natural-scroll';

  final _peripheralsMouseSettings =
      GSettingsSchema.lookup(schemaPeripheralsMouse) != null
          ? GSettings(schemaId: schemaPeripheralsMouse)
          : null;

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
}
