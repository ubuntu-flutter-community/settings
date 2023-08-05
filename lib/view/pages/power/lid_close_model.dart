import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/lid_close_action.dart';

const _lidCloseBatteryActionKey = 'lid-close-battery-action';
const _lidCloseAcActionKey = 'lid-close-ac-action';

class LidCloseModel extends SafeChangeNotifier {
  LidCloseModel(SettingsService settings)
      : _daemonSettings = settings.lookup(schemaSettingsDaemonPowerPlugin) {
    _daemonSettings?.addListener(notifyListeners);
  }
  final Settings? _daemonSettings;

  @override
  void dispose() {
    _daemonSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  LidCloseAction? get acLidCloseAction =>
      _daemonSettings?.stringValue(_lidCloseAcActionKey)?.toLidCloseAction();

  set acLidCloseAction(LidCloseAction? value) {
    if (value != null) {
      _daemonSettings?.setValue(_lidCloseAcActionKey, value.name);
      notifyListeners();
    }
  }

  LidCloseAction? get batteryLidCloseAction => _daemonSettings
      ?.stringValue(_lidCloseBatteryActionKey)
      ?.toLidCloseAction();

  set batteryLidCloseAction(LidCloseAction? value) {
    if (value != null) {
      _daemonSettings?.setValue(_lidCloseBatteryActionKey, value.name);
      notifyListeners();
    }
  }
}
