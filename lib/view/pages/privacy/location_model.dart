import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

const _enabledKey = 'enabled';

class LocationModel extends SafeChangeNotifier {
  LocationModel(SettingsService service)
      : _locationSettings = service.lookup(schemaLocation) {
    _locationSettings?.addListener(notifyListeners);
  }
  final Settings? _locationSettings;

  bool? get enabled => _locationSettings?.getValue(_enabledKey);
  set enabled(bool? value) {
    if (value == null) return;
    _locationSettings?.setValue(_enabledKey, value);
    notifyListeners();
  }

  @override
  void dispose() {
    _locationSettings?.removeListener(notifyListeners);
    super.dispose();
  }
}
