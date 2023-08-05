import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:meta/meta.dart';

@visibleForTesting
const kPowerProfilesInterface = 'net.hadess.PowerProfiles';

@visibleForTesting
const kPowerProfilesPath = '/net/hadess/PowerProfiles';

enum PowerProfile {
  performance,
  balanced,
  powerSaver,
}

class PowerProfileService {
  PowerProfileService([@visibleForTesting DBusRemoteObject? object])
      : _object = object ?? _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.system(),
      name: kPowerProfilesInterface,
      path: DBusObjectPath(kPowerProfilesPath),
    );
  }

  Future<void> init() async {
    await _initProfile();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  PowerProfile? _profile;

  PowerProfile? get profile => _profile;
  Stream<PowerProfile?> get profileChanged => _profileController.stream;
  final _profileController = StreamController<PowerProfile?>.broadcast();

  Future<void> setProfile(PowerProfile? profile) {
    return _object.setProfile(profile);
  }

  void _updateProfile(PowerProfile? profile) {
    if (_profile == profile) return;
    _profile = profile;
    if (!_profileController.isClosed) {
      _profileController.add(_profile);
    }
  }

  Future<void> _initProfile() async {
    _updateProfile(await _object.getProfile());
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    _updateProfile(signal.getChangedProfile());
  }
}

extension _ProfileObject on DBusRemoteObject {
  Future<PowerProfile?> getProfile() async {
    final value = await getProperty(kPowerProfilesInterface, 'ActiveProfile');
    return (value as DBusString).value.toProfileValue();
  }

  Future<void> setProfile(PowerProfile? profile) {
    final value = DBusString(profile?.toProfileString() ?? '');
    return setProperty(kPowerProfilesInterface, 'ActiveProfile', value);
  }
}

extension _ChangedProfile on DBusPropertiesChangedSignal {
  PowerProfile? getChangedProfile() {
    final property = changedProperties['ActiveProfile'] as DBusString?;
    return property?.value.toProfileValue();
  }
}

extension _ProfileValue on String {
  PowerProfile? toProfileValue() {
    switch (this) {
      case 'performance':
        return PowerProfile.performance;
      case 'balanced':
        return PowerProfile.balanced;
      case 'power-saver':
        return PowerProfile.powerSaver;
      default:
        return null;
    }
  }
}

extension _ProfileString on PowerProfile {
  String? toProfileString() {
    switch (this) {
      case PowerProfile.performance:
        return 'performance';
      case PowerProfile.balanced:
        return 'balanced';
      case PowerProfile.powerSaver:
        return 'power-saver';
      default:
        return null;
    }
  }
}
