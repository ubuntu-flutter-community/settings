import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/services/settings_service.dart';

class KeyboardShortcutsModel extends ChangeNotifier {
  final String schemaId;

  KeyboardShortcutsModel(SettingsService service, {required this.schemaId})
      : _shortcutSettings = service.lookup(schemaId);

  final GSettings? _shortcutSettings;

  List<String> shortcut(String shortcutId) {
    final keys = _shortcutSettings?.stringArrayValue(shortcutId);
    return keys?.whereType<String>().toList() ?? [];
  }

  void setShortcut(String shortcutId, List<String> keys) {
    _shortcutSettings?.setValue(shortcutId, keys);
    notifyListeners();
  }
}
