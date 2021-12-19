import 'package:flutter/foundation.dart';
import 'package:settings/services/settings_service.dart';

class KeyboardShortcutsModel extends ChangeNotifier {
  final String schemaId;

  KeyboardShortcutsModel(SettingsService service, {required this.schemaId})
      : _shortcutSettings = service.lookup(schemaId) {
    _shortcutSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _shortcutSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _shortcutSettings;

  List<String> shortcut(String shortcutId) {
    final keys = _shortcutSettings?.stringArrayValue(shortcutId);
    return keys?.whereType<String>().toList() ?? [];
  }

  void setShortcut(String shortcutId, List<String> keys) {
    _shortcutSettings?.setValue(shortcutId, keys);
    notifyListeners();
  }
}
