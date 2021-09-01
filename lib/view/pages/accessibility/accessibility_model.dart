import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';

class AccessibilityModel extends ChangeNotifier {
  static const _schemaId = 'org.gnome.desktop.wm.preferences';
  static const _visualBellKey = 'visual-bell';
  static const _visualBellTypeKey = 'visual-bell-type';
  final _settings = GSettings(schemaId: _schemaId);

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
}
