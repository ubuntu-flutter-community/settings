import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/pages/power/suspend.dart';
import 'package:yaru/yaru.dart';

const _showBatteryPercentageKey = 'show-battery-percentage';
const _powerButtonActionKey = 'power-button-action';

class SuspendModel extends SafeChangeNotifier {
  SuspendModel(GSettingsService settings)
      : _daemonSettings = settings.lookup(schemaSettingsDaemonPowerPlugin),
        _interfaceSettings = settings.lookup(schemaInterface) {
    _daemonSettings?.addListener(notifyListeners);
    _interfaceSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _daemonSettings?.removeListener(notifyListeners);
    _interfaceSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final GnomeSettings? _daemonSettings;
  final GnomeSettings? _interfaceSettings;

  bool? get showBatteryPercentage =>
      _interfaceSettings?.boolValue(_showBatteryPercentageKey);

  void setShowBatteryPercentage(bool value) {
    _interfaceSettings?.setValue(_showBatteryPercentageKey, value);
    notifyListeners();
  }

  PowerButtonAction? get _realPowerButtonAction => _daemonSettings
      ?.stringValue(_powerButtonActionKey)
      ?.toPowerButtonAction();

  PowerButtonAction? get powerButtonAction =>
      PowerButtonAction.values.contains(_realPowerButtonAction)
          ? _realPowerButtonAction
          : null;

  void setPowerButtonAction(PowerButtonAction? value) {
    if (value == null) return;
    _daemonSettings?.setValue(_powerButtonActionKey, value.name);
    notifyListeners();
  }
}
