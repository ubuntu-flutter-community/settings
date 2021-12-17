import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class MultiTaskingModel extends SafeChangeNotifier {
  final Settings? _multiTaskingSettings;
  final Settings? _mutterSettings;

  static const _hotCornersKey = 'enable-hot-corners';
  static const _edgeTilingKey = 'edge-tiling';

  MultiTaskingModel(SettingsService service)
      : _multiTaskingSettings = service.lookup(schemaInterface),
        _mutterSettings = service.lookup(schemaMutter) {
    _multiTaskingSettings?.addListener(notifyListeners);
    _mutterSettings?.addListener(notifyListeners);
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

  bool get edgeTiling => _mutterSettings!.getValue(_edgeTilingKey) ?? false;

  set edgeTiling(bool edgeTiling) {
    _mutterSettings!.setValue(_edgeTilingKey, edgeTiling);
    notifyListeners();
  }
}
