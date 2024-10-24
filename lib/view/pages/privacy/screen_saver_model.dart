import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:yaru/yaru.dart';

const _lockEnabledKey = 'lock-enabled';
const _lockDelayKey = 'lock-delay';
const _ubuntuLockOnSuspendKey = 'ubuntu-lock-on-suspend';
const _showInLockScreenKey = 'show-in-lock-screen';
const _idleDelayKey = 'idle-delay';

class ScreenSaverModel extends SafeChangeNotifier {
  ScreenSaverModel(GSettingsService service)
      : _screenSaverSettings = service.lookup(schemaScreenSaver),
        _notificationSettings = service.lookup(schemaNotifications),
        _sessionSettings = service.lookup(schemaSession) {
    _screenSaverSettings?.addListener(notifyListeners);
    _notificationSettings?.addListener(notifyListeners);
    _sessionSettings?.addListener(notifyListeners);
  }
  final GnomeSettings? _screenSaverSettings;
  final GnomeSettings? _notificationSettings;
  final GnomeSettings? _sessionSettings;

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

  int? get _realLockDelay => _screenSaverSettings?.intValue(_lockDelayKey);
  int? get lockDelay =>
      ScreenLockDelay.values.contains(_realLockDelay) ? _realLockDelay : null;
  set lockDelay(int? value) {
    if (value == null) return;
    _screenSaverSettings?.setUint32Value(_lockDelayKey, value);
    notifyListeners();
  }

  int? get _realIdleDelay =>
      IdleDelay.validate(_sessionSettings?.intValue(_idleDelayKey));
  int? get idleDelay =>
      IdleDelay.values.contains(_realIdleDelay) ? _realIdleDelay : null;
  void setIdleDelay(int? value) {
    if (value == null) return;
    _sessionSettings?.setUint32Value(_idleDelayKey, value);
    notifyListeners();
  }
}
