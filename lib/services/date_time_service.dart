import 'dart:async';

import 'package:dbus/dbus.dart';

const kDateTimeInterface = 'org.freedesktop.timedate1';
const kDateTimePath = '/org/freedesktop/timedate1';
const kListTimezoneMethodName = 'ListTimezones';
const kSetLocalRtcMethodName = 'SetLocalRTC';
const kSetNtpMethodName = 'SetNTP';
const kSetTimeMethodName = 'SetTime';
const kSetTimezoneMethodName = 'SetTimezone';
const kCanNTPPropertyName = 'CanNTP';
const kLocalRTCPropertyName = 'LocalRTC';
const kNTPPropertyName = 'NTP';
const kNTPSynchronizedPropertyName = 'NTPSynchronized';
const kTimezonePropertyName = 'Timezone';
const kRTCTimeUSecPropertyName = 'RTCTimeUSec';
const kTimeUSecPropertyName = 'TimeUSec';

class DateTimeService {
  DateTimeService() : _object = _createObject();

  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  static DBusRemoteObject _createObject() =>
      DBusRemoteObject(DBusClient.system(),
          name: kDateTimeInterface, path: DBusObjectPath(kDateTimePath));

  Future<void> init() async {
    await _initTimezone();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  String? _timezone;
  String? get timezone => _timezone;
  Stream<String?> get timezoneChanged => _timezoneController.stream;
  final _timezoneController = StreamController<String?>.broadcast();

  void _updateTimezone(String? value) {
    if (_timezone == value) return;
    _timezone = value;
    if (!_timezoneController.isClosed) {
      _timezoneController.add(_timezone);
    }
  }

  Future<void> _initTimezone() async {
    _updateTimezone(await _object.getTimezone());
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    if (signal.hasChangedTimeZone()) {
      _object.getTimezone().then(_updateTimezone);
    }
  }
}

extension _DateTimeRemoteObject on DBusRemoteObject {
  Future<String?> getTimezone() async {
    final timeZone =
        await getProperty(kDateTimeInterface, kTimezonePropertyName);
    return (timeZone as DBusString).value;
  }

  Future<void> setTimeZone(String timezone) async {
    return setProperty(
        kDateTimeInterface, kSetTimeMethodName, DBusString(timezone));
  }
}

extension _ChangedDateTime on DBusPropertiesChangedSignal {
  bool hasChangedTimeZone() =>
      changedProperties.containsKey(kTimezonePropertyName);
}
