import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/keyboard_service.dart';
import 'package:yaru/yaru.dart';

class KeyboardShortcutsModel extends SafeChangeNotifier {
  KeyboardShortcutsModel({
    required KeyboardService keyboard,
    required GSettingsService settings,
    required this.schemaId,
  })  : _keyboard = keyboard,
        _shortcutSettings = settings.lookup(schemaId) {
    _shortcutSettings?.addListener(notifyListeners);
  }
  final String schemaId;

  @override
  void dispose() {
    _shortcutSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final KeyboardService _keyboard;
  final GnomeSettings? _shortcutSettings;

  Future<bool> grabKeyboard() => _keyboard.grab();
  Future<bool> ungrabKeyboard() => _keyboard.ungrab();

  List<String> getShortcutStrings(String shortcutId) {
    final keys = _shortcutSettings?.stringArrayValue(shortcutId);
    return keys?.whereType<String>().toList() ?? [];
  }

  void setShortcut(String shortcutId, List<String> keys) {
    _shortcutSettings?.setValue(shortcutId, keys);
    notifyListeners();
  }
}
