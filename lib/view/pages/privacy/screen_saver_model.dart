import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/power_settings.dart';

const _lockEnabledKey = 'lock-enabled';
const _lockDelayKey = 'lock-delay';
const _ubuntuLockOnSuspendKey = 'ubuntu-lock-on-suspend';
const _showInLockScreenKey = 'show-in-lock-screen';
const _idleDelayKey = 'idle-delay';

class ScreenSaverModel extends SafeChangeNotifier {
  final Settings? _screenSaverSettings;
  final Settings? _notificationSettings;
  final Settings? _sessionSettings;

  ScreenSaverModel(SettingsService service)
      : _screenSaverSettings = service.lookup(schemaScreenSaver),
        _notificationSettings = service.lookup(schemaNotifications),
        _sessionSettings = service.lookup(schemaSession) {
    _screenSaverSettings?.addListener(notifyListeners);
    _notificationSettings?.addListener(notifyListeners);
    _sessionSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _screenSaverSettings?.removeListener(notifyListeners);
    _notificationSettings?.removeListener(notifyListeners);
    _sessionSettings?.removeListener(notifyListeners);

    super.dispose();
  }

  bool? get lockEnabled => _screenSaverSettings?.boolValue(_lockEnabledKey);
  set lockEnabled(bool? value) {
    if (value == null) return;
    _screenSaverSettings?.setValue(_lockEnabledKey, value);
    notifyListeners();
  }

  bool? get showOnLockScreen =>
      _notificationSettings?.boolValue(_showInLockScreenKey);
  set showOnLockScreen(bool? value) {
    if (value == null) return;
    _notificationSettings?.setValue(_showInLockScreenKey, value);
    notifyListeners();
  }

  bool? get ubuntuLockOnSuspend =>
      _screenSaverSettings?.boolValue(_ubuntuLockOnSuspendKey);
  set ubuntuLockOnSuspend(bool? value) {
    if (value == null) return;
    _screenSaverSettings?.setValue(_ubuntuLockOnSuspendKey, value);
    notifyListeners();
  }

  int? get lockDelay => _screenSaverSettings?.intValue(_lockDelayKey);
  set lockDelay(int? value) {
    if (value == null) return;
    _screenSaverSettings?.setValue(_lockDelayKey, value);
    notifyListeners();
  }

  int? get _realIdleDelay =>
      IdleDelay.validate(_sessionSettings?.intValue(_idleDelayKey));
  int? get idleDelay =>
      IdleDelay.values.contains(_realIdleDelay) ? _realIdleDelay : null;
  void setIdleDelay(int? value) {
    if (value == null) return;
    _sessionSettings?.setValue(_idleDelayKey, value);
    notifyListeners();
  }
}
