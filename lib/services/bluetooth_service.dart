import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:meta/meta.dart';

@visibleForTesting
const kRfkillInterface = 'org.gnome.SettingsDaemon.Rfkill';

@visibleForTesting
const kRfkillPath = '/org/gnome/SettingsDaemon/Rfkill';

class BluetoothService {
  BluetoothService([@visibleForTesting DBusRemoteObject? object])
      : _object = object ?? _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.session(),
      name: kRfkillInterface,
      path: DBusObjectPath(kRfkillPath),
    );
  }

  Future<void> init() async {
    await _initProperties();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  bool? _hasAirplaneMode;
  bool? _airplaneMode;

  bool get hasAirplaneMode => _hasAirplaneMode ?? true;

  bool? get airplaneMode => _airplaneMode;
  Stream<bool?> get airplaneModeChanged => _airplaneModeController.stream;
  final _airplaneModeController = StreamController<bool?>.broadcast();

  Future<void> setAirplaneMode(bool? airplaneMode) {
    return _object.setAirplaneMode(airplaneMode);
  }

  void _updateAirplaneMode(bool? airplaneMode) {
    if (_airplaneMode == airplaneMode) return;
    _airplaneMode = airplaneMode;
    if (!_airplaneModeController.isClosed) {
      _airplaneModeController.add(_airplaneMode);
    }
  }

  Future<void> _initProperties() async {
    _hasAirplaneMode = await _object.getHasAirplaneMode();
    _updateAirplaneMode(await _object.getAirplaneMode());
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    _updateAirplaneMode(signal.getChangedAirplaneMode());
  }
}

extension _AirplaneModeObject on DBusRemoteObject {
  Future<bool?> getHasAirplaneMode() async {
    final value =
        await getProperty(kRfkillInterface, 'BluetoothHasAirplaneMode');
    return (value as DBusBoolean).value;
  }

  Future<bool?> getAirplaneMode() async {
    final value = await getProperty(kRfkillInterface, 'BluetoothAirplaneMode');
    return (value as DBusBoolean).value;
  }

  Future<void> setAirplaneMode(bool? airplaneMode) {
    final value = DBusBoolean(airplaneMode ?? false);
    return setProperty(kRfkillInterface, 'BluetoothAirplaneMode', value);
  }
}

extension _ChangedAirplaneMode on DBusPropertiesChangedSignal {
  bool? getChangedAirplaneMode() {
    final property = changedProperties['BluetoothAirplaneMode'] as DBusBoolean?;
    return property?.value;
  }
}
