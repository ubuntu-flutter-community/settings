import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/suspend.dart';

const _kDaemonSchema = 'org.gnome.settings-daemon.plugins.power';
const _kInterfaceSchema = 'org.gnome.desktop.interface';

class SuspendModel extends SafeChangeNotifier {
  SuspendModel(SettingsService settings)
      : _daemonSettings = settings.lookup(_kDaemonSchema),
        _interfaceSettings = settings.lookup(_kInterfaceSchema) {
    _daemonSettings?.addListener(notifyListeners);
    _interfaceSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _daemonSettings?.removeListener(notifyListeners);
    _interfaceSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _daemonSettings;
  final Settings? _interfaceSettings;

  bool? get showBatteryPercentage =>
      _interfaceSettings?.boolValue('show-battery-percentage');
  void setShowBatteryPercentage(bool value) {
    _interfaceSettings?.setValue('show-battery-percentage', value);
    notifyListeners();
  }

  PowerButtonAction? get powerButtonAction => _daemonSettings
      ?.stringValue('power-button-action')
      ?.toPowerButtonAction();
  void setPowerButtonAction(PowerButtonAction? value) {
    if (value == null) return;
    _daemonSettings?.setValue('power-button-action', value.name);
    notifyListeners();
  }
}
