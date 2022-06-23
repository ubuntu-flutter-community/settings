import 'dart:async';

import 'package:dbus/dbus.dart';

const _kDateTimeInterface = 'org.freedesktop.timedate1';
const _kDateTimePath = '/org/freedesktop/timedate1';
// const _kListTimezoneMethodName = 'ListTimezones';
// const _kSetLocalRtcMethodName = 'SetLocalRTC';
const _kSetNtpMethodName = 'SetNTP';
const _kSetTimeMethodName = 'SetTime';
const _kSetTimezoneMethodName = 'SetTimezone';
// const _kCanNTPPropertyName = 'CanNTP';
// const _kLocalRTCPropertyName = 'LocalRTC';
const _kNTPPropertyName = 'NTP';
// const _kNTPSynchronizedPropertyName = 'NTPSynchronized';
// const _kRTCTimeUSecPropertyName = 'RTCTimeUSec';
const _kTimeUSecPropertyName = 'TimeUSec';
const _kTimezonePropertyName = 'Timezone';

class DateTimeService {
  DateTimeService() : _object = _createObject();

  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  static DBusRemoteObject _createObject() => DBusRemoteObject(
        DBusClient.system(),
        name: _kDateTimeInterface,
        path: DBusObjectPath(_kDateTimePath),
      );

  Future<void> init() async {
    await _initTimezone();
    await _initNtp();
    _dateTime = await getDateTime();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    if (signal.hasChangedTimeZone()) {
      _object.getTimezone().then(_updateTimezone);
      _object.getDateTime().then(_updateDateTime);
    }
    if (signal.hasChangedDateTime()) {
      _object.getDateTime().then(_updateDateTime);
    }
    if (signal.hasChangedNtp()) {
      _object.getNtp().then(_updateNtp);
    }
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  // Timezone
  String? _timezone;
  String? get timezone => _timezone;
  set timezone(String? value) {
    if (value == null) return;
    _object.setTimeZone(value);
  }

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

  // Date and time
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? dateTime) {
    if (dateTime == null) return;
    _object.setTime(dateTime.microsecondsSinceEpoch);
  }

  void _updateDateTime(DateTime? value) {
    if (_dateTime?.second == value?.second) return;
    getDateTime().then((value) => _dateTime = value);
  }

  Future<DateTime?> getDateTime() async {
    return await _object.getDateTime();
  }

  // NTP
  bool? _ntp;
  bool? get ntp => _ntp;
  set ntp(bool? value) {
    if (value == null) return;
    _object.setNtp(value);
  }

  Stream<bool?> get ntpChanged => _ntpController.stream;
  final _ntpController = StreamController<bool?>.broadcast();

  void _updateNtp(bool? value) {
    if (_ntp == value) return;
    _ntp = value;
    if (!_ntpController.isClosed) {
      _ntpController.add(_ntp);
    }
  }

  Future<void> _initNtp() async {
    _updateNtp(await _object.getNtp());
  }
}

extension _DateTimeRemoteObject on DBusRemoteObject {
  Future<String?> getTimezone() async {
    final timeZone =
        await getProperty(_kDateTimeInterface, _kTimezonePropertyName);
    return (timeZone as DBusString).value;
  }

  Future<void> setTimeZone(String timezone) async {
    final args = [DBusString(timezone), const DBusBoolean(false)];
    callMethod(_kDateTimeInterface, _kSetTimezoneMethodName, args);
  }

  Future<void> setTime(int time) async {
    bool? ntp = await getNtp();
    if (ntp == null || ntp == true) return;
    final args = [
      DBusInt64(time),
      const DBusBoolean(false),
      const DBusBoolean(false)
    ];
    callMethod(_kDateTimeInterface, _kSetTimeMethodName, args);
  }

  Future<DateTime?> getDateTime() async {
    final timeUSec =
        await getProperty(_kDateTimeInterface, _kTimeUSecPropertyName);
    return DateTime.fromMicrosecondsSinceEpoch((timeUSec as DBusUint64).value);
  }

  Future<bool?> getNtp() async {
    final ntpSync = await getProperty(_kDateTimeInterface, _kNTPPropertyName);
    return (ntpSync as DBusBoolean).value;
  }

  Future<void> setNtp(bool? value) async {
    if (value == null) return;
    final args = [DBusBoolean(value), const DBusBoolean(false)];
    callMethod(_kDateTimeInterface, _kSetNtpMethodName, args);
  }
}

extension _ChangedDateTime on DBusPropertiesChangedSignal {
  bool hasChangedTimeZone() {
    return changedProperties.containsKey(_kTimezonePropertyName);
  }

  bool hasChangedDateTime() {
    return changedProperties.containsKey(_kTimeUSecPropertyName);
  }

  bool hasChangedNtp() {
    return changedProperties.containsKey(_kNTPPropertyName);
  }
}
