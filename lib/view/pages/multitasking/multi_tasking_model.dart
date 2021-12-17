import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class MultiTaskingModel extends SafeChangeNotifier {
  final Settings? _multiTaskingSettings;

  static const _hotCornersKey = 'enable-hot-corners';

  MultiTaskingModel(SettingsService service)
      : _multiTaskingSettings = service.lookup(schemaInterface) {
    _multiTaskingSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _multiTaskingSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool get enableHotCorners =>
      _multiTaskingSettings!.boolValue(_hotCornersKey) ?? false;

  set enableHotCorners(bool enableHotCorners) {
    _multiTaskingSettings!.setValue(_hotCornersKey, enableHotCorners);
    notifyListeners();
  }
}
