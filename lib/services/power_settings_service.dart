import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:meta/meta.dart';

@visibleForTesting
const kPowerSettingsInterface = 'org.gnome.SettingsDaemon.Power';

@visibleForTesting
const kPowerSettingsPath = '/org/gnome/SettingsDaemon/Power';

class PowerSettingsService {
  final screen = Brightness('Screen');
  final keyboard = Brightness('Keyboard');

  Future<void> init() => Future.wait([screen.init(), keyboard.init()]);

  Future<void> dispose() => Future.wait([screen.dispose(), keyboard.dispose()]);
}

class Brightness {
  Brightness(String name, [@visibleForTesting DBusRemoteObject? object])
      : _name = name,
        _object = object ?? _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.session(),
      name: kPowerSettingsInterface,
      path: DBusObjectPath(kPowerSettingsPath),
    );
  }

  Future<void> init() async {
    await _initBrightness();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  final String _name;
  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  int? _brightness;

  int? get brightness => _brightness;

  Stream<int?> get brightnessChanged => _brightnessController.stream;
  final _brightnessController = StreamController<int?>.broadcast();

  Future<void> setBrightness(int? brightness) {
    return _object.setBrightness(brightness, _name);
  }

  void _updateBrightness(int? brightness) {
    if (_brightness == brightness) return;
    _brightness = brightness;
    if (!_brightnessController.isClosed) {
      _brightnessController.add(_brightness);
    }
  }

  Future<void> _initBrightness() async {
    _updateBrightness(await _object.getBrightness(_name));
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    if (_name == 'Screen') {
      if (signal.hasChangedScreenBrightness()) {
        _object.getBrightness(_name).then(_updateBrightness);
      }
    } else {
      if (signal.hasChangedKeyboardBrightness()) {
        _object.getBrightness(_name).then(_updateBrightness);
      }
    }
  }
}

extension _BrightnessObject on DBusRemoteObject {
  Future<int?> getBrightness(String name) async {
    final value =
        await getProperty('$kPowerSettingsInterface.$name', 'Brightness');
    return (value as DBusInt32).value;
  }

  Future<void> setBrightness(int? brightness, String name) {
    final value = DBusInt32(brightness ?? 100);
    return setProperty('$kPowerSettingsInterface.$name', 'Brightness', value);
  }
}

extension _ChangedBrightness on DBusPropertiesChangedSignal {
  bool hasChangedScreenBrightness() {
    return changedProperties.containsKey('Brightness') &&
        propertiesInterface.contains('Screen');
  }

  bool hasChangedKeyboardBrightness() {
    return changedProperties.containsKey('Brightness') &&
        propertiesInterface.contains('Keyboard');
  }
}
