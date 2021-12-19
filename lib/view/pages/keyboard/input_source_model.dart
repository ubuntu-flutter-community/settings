import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class InputSourceModel extends SafeChangeNotifier {
  final Settings? _inputSourceSettings;
  static const _perWindowKey = 'per-window';
  static const _currentSourceKey = 'current';
  static const _sourcesKey = 'sources';

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

  int? get currentSource => _inputSourceSettings?.intValue(_currentSourceKey);

  set currentSource(int? value) {
    _inputSourceSettings?.setValue(_currentSourceKey, value);
    notifyListeners();
  }

  // List<String>? get sources {
  //   final sources = _inputSourceSettings?.stringArrayValue(_sourcesKey);
  //   return sources?.map((e) => e.toString()).toList();
  // }

  // set sources(???????????? value) {
  //   _inputSourceSettings?.setValue(_sourcesKey, value);
  //   notifyListeners();
  // }
}
