import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

const _setNightLight = 'night-light-enabled';
const _setNightlightTemp = 'night-light-temperature';
const _setNightlightScheduleFrom = 'night-light-schedule-from';
const _setNightlightScheduleTo = 'night-light-schedule-to';

class NightlightModel extends SafeChangeNotifier {
  NightlightModel(SettingsService service)
      : _soundSettings = service.lookup(schemaSettingsDaemonColorPlugin) {
    _soundSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _soundSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _soundSettings;

  bool? get nightLightEnabled => _soundSettings?.boolValue(_setNightLight);

  void setNightLightEnabled(bool? value) {
    _soundSettings?.setValue(_setNightLight, value!);
    notifyListeners();
  }

  double? get nightLightTemp =>
      _soundSettings?.intValue(_setNightlightTemp)!.toDouble();

  void setNightLightTemp(double? value) {
    _soundSettings?.setUint32Value(_setNightlightTemp, value!.toInt());
    notifyListeners();
  }
}
