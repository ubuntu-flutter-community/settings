import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class InputSourceModel extends SafeChangeNotifier {
  final Settings? _inputSourceSettings;
  static const _perWindowKey = 'per-window';
  static const _sourcesKey = 'sources';
  static const _xkbOptionsKey = 'xkb-options';

  InputSourceModel(SettingsService service)
      : _inputSourceSettings = service.lookup(schemaInputSources) {
    _inputSourceSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _inputSourceSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool get perWindow => _inputSourceSettings?.getValue(_perWindowKey) ?? false;

  set perWindow(bool value) {
    _inputSourceSettings?.setValue(_perWindowKey, value);
    notifyListeners();
  }

  Iterable<dynamic>? get sources =>
      _inputSourceSettings?.getValue<Iterable<dynamic>>(_sourcesKey);

  set sources(Iterable<dynamic>? value) {
    _inputSourceSettings?.setValue<Iterable<dynamic>>(_sourcesKey, value!);
    notifyListeners();
  }

  List<String>? get xkbOptions =>
      _inputSourceSettings?.getValue(_xkbOptionsKey);

  set xkbOptions(List<String>? value) {
    _inputSourceSettings?.setValue(_xkbOptionsKey, value);
    notifyListeners();
  }
}
