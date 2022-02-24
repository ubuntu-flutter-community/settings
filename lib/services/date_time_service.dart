import 'dart:async';

import 'package:dbus/dbus.dart';

const _kDateTimeInterface = 'org.freedesktop.timedate1';
const _kDateTimePath = '/org/freedesktop/timedate1';
// const _kListTimezoneMethodName = 'ListTimezones';
// const _kSetLocalRtcMethodName = 'SetLocalRTC';
// const _kSetNtpMethodName = 'SetNTP';
// const _kSetTimeMethodName = 'SetTime';
const _kSetTimezoneMethodName = 'SetTimezone';
// const _kCanNTPPropertyName = 'CanNTP';
// const _kLocalRTCPropertyName = 'LocalRTC';
// const _kNTPPropertyName = 'NTP';
// const _kNTPSynchronizedPropertyName = 'NTPSynchronized';
// const _kRTCTimeUSecPropertyName = 'RTCTimeUSec';
const _kTimeUSecPropertyName = 'TimeUSec';
const _kTimezonePropertyName = 'Timezone';

class DateTimeService {
  DateTimeService() : _object = _createObject();

  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  static DBusRemoteObject _createObject() =>
      DBusRemoteObject(DBusClient.system(),
          name: _kDateTimeInterface, path: DBusObjectPath(_kDateTimePath));

  Future<void> init() async {
    await _initTimezone();
    await _initDateTime();
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

  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  Stream<DateTime?> get dateTimeChanged => _dateTimeController.stream;
  final _dateTimeController = StreamController<DateTime?>.broadcast();

  void _updateDateTime(DateTime? value) {
    if (_dateTime?.second == value?.second) return;
    _dateTime = value;
    if (!_dateTimeController.isClosed) {
      _dateTimeController.add(_dateTime);
    }
  }

  Future<void> _initDateTime() async {
    _updateDateTime(await _object.getDateTime());
  }

  Future<DateTime?> getDateTime() async {
    return await _object.getDateTime();
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    if (signal.hasChangedTimeZone()) {
      _object.getTimezone().then(_updateTimezone);
    }
    if (signal.hasChangedDateTime()) {
      _object.getDateTime().then(_updateDateTime);
    }
  }
}

extension _DateTimeRemoteObject on DBusRemoteObject {
  Future<String?> getTimezone() async {
    final timeZone =
        await getProperty(_kDateTimeInterface, _kTimezonePropertyName);
    return (timeZone as DBusString).value;
  }

  Future<void> setTimeZone(String timezone) async {
    return setProperty(
        _kDateTimeInterface, _kSetTimezoneMethodName, DBusString(timezone));
  }

  Future<DateTime?> getDateTime() async {
    final timeUSec =
        await getProperty(_kDateTimeInterface, _kTimeUSecPropertyName);
    return DateTime.fromMicrosecondsSinceEpoch((timeUSec as DBusUint64).value);
  }
}

extension _ChangedDateTime on DBusPropertiesChangedSignal {
  bool hasChangedTimeZone() {
    return changedProperties.containsKey(_kTimezonePropertyName);
  }

  bool hasChangedDateTime() {
    return changedProperties.containsKey(_kTimeUSecPropertyName);
  }
}
