import 'package:flutter/foundation.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class KeyboardShortcutsModel extends ChangeNotifier {
  final Settings? wmKeyBindingsSettings;
  final Settings? gnomeShellBindingsSettings;

  KeyboardShortcutsModel(SettingsService service)
      : wmKeyBindingsSettings = service.lookup(schemaWmKeybindings),
        gnomeShellBindingsSettings =
            service.lookup(schemaGnomeShellKeybinding) {
    wmKeyBindingsSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    wmKeyBindingsSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  List<String> shortcut(String shortcutId) {
    final keys = wmKeyBindingsSettings?.stringArrayValue(shortcutId);
    return keys?.whereType<String>().toList() ?? [];
  }

  void setShortcut(String shortcutId, List<String> keys) {
    wmKeyBindingsSettings?.setValue(shortcutId, keys);
    notifyListeners();
  }
}
