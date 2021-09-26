import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/suspend.dart';

const _kDaemonSchema = 'org.gnome.settings-daemon.plugins.power';
const _kInterfaceSchema = 'org.gnome.desktop.interface';

class SuspendModel extends SafeChangeNotifier {
  SuspendModel(SettingsService settings)
      : _daemonSettings = settings.lookup(_kDaemonSchema),
        _interfaceSettings = settings.lookup(_kInterfaceSchema);

  final GSettings? _daemonSettings;
  final GSettings? _interfaceSettings;

  bool? get showBatteryPercentage =>
      _interfaceSettings?.boolValue('show-battery-percentage');
  void setShowBatteryPercentage(bool value) {
    _interfaceSettings?.setValue('show-battery-percentage', value);
    notifyListeners();
  }

  PowerButtonAction? get powerButtonAction =>
      (_daemonSettings?.enumValue('power-button-action') ?? -1)
          .toPowerButtonAction();
  void setPowerButtonAction(PowerButtonAction? value) {
    if (value == null) return;
    _daemonSettings?.setEnumValue('power-button-action', value.index);
    notifyListeners();
  }
}
