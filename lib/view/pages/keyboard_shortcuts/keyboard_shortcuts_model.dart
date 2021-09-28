import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class KeyboardShortcutsModel extends ChangeNotifier {
  final _shortcutSettings = GSettingsSchema.lookup(schemaWmKeybindings) != null
      ? GSettings(schemaId: schemaWmKeybindings)
      : null;

  @override
  void dispose() {
    _shortcutSettings?.dispose();
    super.dispose();
  }

  List<String> shortcut(String shortcutId) {
    final keys = _shortcutSettings?.stringArrayValue(shortcutId);
    return keys?.whereType<String>().toList() ?? [];
  }

  void setShortcut(String shortcutId, List<String> keys) {
    _shortcutSettings?.setValue(shortcutId, keys);
    notifyListeners();
  }
}
