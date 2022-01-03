import 'dart:async';

import 'package:nm/nm.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/power_settings.dart';

const _kDaemonSchema = 'org.gnome.settings-daemon.plugins.power';
const _kSessionSchema = 'org.gnome.desktop.session';

class SuspendModel extends SafeChangeNotifier {
  SuspendModel({
    required SettingsService settings,
    required PowerSettingsService power,
    required BluetoothService bluetooth,
    required NetworkManagerClient network,
  })  : _daemonSettings = settings.lookup(_kDaemonSchema),
        _sessionSettings = settings.lookup(_kSessionSchema),
        _powerService = power,
        _bluetoothService = bluetooth,
        _networkManager = network {
    _daemonSettings?.addListener(notifyListeners);
    _sessionSettings?.addListener(notifyListeners);
  }

  final Settings? _daemonSettings;
  final Settings? _sessionSettings;
  final BluetoothService _bluetoothService;
  final NetworkManagerClient _networkManager;
  final PowerSettingsService _powerService;
  StreamSubscription<bool?>? _airplaneMode;
  StreamSubscription<int?>? _screenBrightness;
  StreamSubscription<int?>? _keyboardBrightness;

  Future<void> init() {
    final power = _powerService.init().then((_) {
      _screenBrightness = _powerService.screen.brightnessChanged.listen((_) {
        notifyListeners();
      });
      _keyboardBrightness =
          _powerService.keyboard.brightnessChanged.listen((_) {
        notifyListeners();
      });
    });
    final bluetooth = _bluetoothService.init().then((_) {
      _airplaneMode = _bluetoothService.airplaneModeChanged.listen((_) {
        notifyListeners();
      });
      notifyListeners();
    });
    final network = _networkManager.connect();
    return Future.wait([power, bluetooth, network]);
  }

  @override
  Future<void> dispose() async {
    _daemonSettings?.removeListener(notifyListeners);
    _sessionSettings?.removeListener(notifyListeners);
    await _airplaneMode?.cancel();
    await _screenBrightness?.cancel();
    await _keyboardBrightness?.cancel();
    super.dispose();
  }

  bool? get ambientEnabled => _daemonSettings?.boolValue('ambient-enabled');
  void setAmbientEnabled(bool value) {
    _daemonSettings?.setValue('ambient-enabled', value);
    notifyListeners();
  }

  bool? get idleDim => _daemonSettings?.boolValue('idle-dim');
  void setIdleDim(bool value) {
    _daemonSettings?.setValue('idle-dim', value);
    notifyListeners();
  }

  int? get _realIdleDelay =>
      IdleDelay.validate(_sessionSettings?.intValue('idle-delay'));
  int? get idleDelay =>
      IdleDelay.values.contains(_realIdleDelay) ? _realIdleDelay : null;
  void setIdleDelay(int? value) {
    if (value == null) return;
    _sessionSettings?.setValue('idle-delay', value);
    notifyListeners();
  }

  double? get screenBrightness => _powerService.screen.brightness?.toDouble();
  void setScreenBrightness(double? value) {
    _powerService.screen.setBrightness(value?.toInt());
    notifyListeners();
  }

  double? get keyboardBrightness =>
      _powerService.keyboard.brightness?.toDouble();
  void setKeyboardBrightness(double? value) {
    _powerService.keyboard.setBrightness(value?.toInt());
    notifyListeners();
  }

  bool get suspendOnBattery =>
      _sleepInactiveType('sleep-inactive-battery-type') ==
      SleepInactiveType.suspend;
  void setSuspendOnBattery(bool value) {
    _setSleepInactiveType('sleep-inactive-battery-type',
        value ? SleepInactiveType.suspend : SleepInactiveType.nothing);
  }

  bool get suspendWhenPluggedIn =>
      _sleepInactiveType('sleep-inactive-ac-type') == SleepInactiveType.suspend;
  void setSuspendWhenPluggedIn(bool value) {
    _setSleepInactiveType('sleep-inactive-ac-type',
        value ? SleepInactiveType.suspend : SleepInactiveType.nothing);
  }

  SleepInactiveType? _sleepInactiveType(String key) =>
      _daemonSettings?.stringValue(key)?.toSleepInactiveType();
  void _setSleepInactiveType(String key, SleepInactiveType value) {
    _daemonSettings?.setValue(key, value.name);
    notifyListeners();
  }

  int? get suspendOnBatteryDelay => SuspendDelay.validate(
      _daemonSettings?.intValue('sleep-inactive-battery-timeout'));
  void setSuspendOnBatteryDelay(int? value) {
    if (value == null) return;
    _daemonSettings?.setValue('sleep-inactive-battery-timeout', value);
    notifyListeners();
  }

  int? get suspendWhenPluggedInDelay => SuspendDelay.validate(
      _daemonSettings?.intValue('sleep-inactive-ac-timeout'));
  void setSuspendWhenPluggedInDelay(int? value) {
    if (value == null) return;
    _daemonSettings?.setValue('sleep-inactive-ac-timeout', value);
    notifyListeners();
  }

  AutomaticSuspend get automaticSuspend {
    if (suspendOnBattery && suspendWhenPluggedIn) {
      return AutomaticSuspend.both;
    }
    if (suspendOnBattery) return AutomaticSuspend.battery;
    if (suspendWhenPluggedIn) return AutomaticSuspend.pluggedIn;
    return AutomaticSuspend.off;
  }

  bool get hasWifi => _networkManager.devices.any((d) => d.wireless != null);
  bool? get wifiEnabled => _networkManager.wirelessEnabled;
  void setWifiEnabled(bool? value) {
    if (value == null) return;
    _networkManager.setWirelessEnabled(value).then((_) => notifyListeners());
  }

  bool get hasBluetooth => _bluetoothService.hasAirplaneMode;
  bool? get bluetoothEnabled => !(_bluetoothService.airplaneMode ?? true);
  void setBluetoothEnabled(bool? value) {
    if (value == null) return;
    _bluetoothService.setAirplaneMode(!value).then((_) => notifyListeners());
  }
}
