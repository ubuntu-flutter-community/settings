import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/date_time_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:intl/intl.dart';

const _kAutomaticTimezone = 'automatic-timezone';
const _kClockFormat = 'clock-format';
const _kClockShowSeconds = 'clock-show-seconds';
const _kClockShowWeekDay = 'clock-show-weekday';
const _kCalendarShowWeekNumber = 'show-weekdate';

class DateTimeModel extends SafeChangeNotifier {
  final Settings? _dateTimeSettings;
  final Settings? _interfaceSettings;
  final Settings? _calendarSettings;
  final DateTimeService _dateTimeService;
  StreamSubscription<String?>? _timezoneSub;
  StreamSubscription<bool?>? _ntpSyncSub;
  Timer? _fetchDateTimeTimer;
  DateTime? _dateTime;

  DateTimeModel(
      {required DateTimeService dateTimeService,
      required SettingsService settingsService})
      : _dateTimeService = dateTimeService,
        _dateTimeSettings = settingsService.lookup(schemaDateTime),
        _interfaceSettings = settingsService.lookup(schemaInterface),
        _calendarSettings = settingsService.lookup(schemaCalendar) {
    _dateTimeSettings?.addListener(notifyListeners);
    _interfaceSettings?.addListener(notifyListeners);
    _calendarSettings?.addListener(notifyListeners);
  }

  Future<void> init() {
    return _dateTimeService.init().then((_) async {
      _timezoneSub = _dateTimeService.timezoneChanged.listen((_) {
        notifyListeners();
      });
      _ntpSyncSub = _dateTimeService.ntpChanged.listen((_) {
        notifyListeners();
      });
      _dateTime = await _dateTimeService.getDateTime();
      notifyListeners();

      _fetchDateTimeTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          _dateTime = await _dateTimeService.getDateTime();
          notifyListeners();
        },
      );
    });
  }

  @override
  Future<void> dispose() async {
    _fetchDateTimeTimer?.cancel();
    await _timezoneSub?.cancel();
    await _ntpSyncSub?.cancel();
    _dateTimeSettings?.removeListener(notifyListeners);
    _interfaceSettings?.removeListener(notifyListeners);
    _calendarSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  String get timezone {
    if (dateTime == null || _dateTimeService.timezone == null) return '';
    return dateTime!.timeZoneName +
        ': ' +
        _dateTimeService.timezone!.toString();
  }

  set timezone(String value) {
    _dateTimeService.timezone = value;
    notifyListeners();
  }

  String getLocalDateName(BuildContext context) {
    if (dateTime == null) return '';
    return DateFormat.yMMMMEEEEd(context.l10n.localeName).format(dateTime!);
  }

  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? dateTime) {
    if (dateTime == null) return;
    _dateTimeService.dateTime = dateTime;
    notifyListeners();
  }

  bool? get automaticDateTime => _dateTimeService.ntp;
  set automaticDateTime(bool? value) {
    if (value == null) return;
    _dateTimeService.ntp = value;
    notifyListeners();
  }

  bool? get automaticTimezone =>
      _dateTimeSettings?.getValue(_kAutomaticTimezone);
  set automaticTimezone(bool? value) {
    if (value == null) return;
    _dateTimeSettings?.setValue(_kAutomaticTimezone, value);
    notifyListeners();
  }

  String? get _clockFormat => _interfaceSettings?.getValue(_kClockFormat);
  set _clockFormat(String? value) {
    if (value == null) return;
    _interfaceSettings?.setValue(_kClockFormat, value);
    notifyListeners();
  }

  bool? get clockIsTwentyFourFormat => _clockFormat?.contains('24h');
  set clockIsTwentyFourFormat(bool? value) {
    if (value == null) return;
    _clockFormat = value ? '24h' : '12h';
  }

  String get clock => dateTime != null
      ? dateTime!.hour.toString().padLeft(2, '0') +
          ':' +
          dateTime!.minute.toString().padLeft(2, '0') +
          ':' +
          dateTime!.second.toString().padLeft(2, '0')
      : '';

  bool? get clockShowSeconds =>
      _interfaceSettings?.getValue(_kClockShowSeconds);
  set clockShowSeconds(bool? value) {
    if (value == null) return;
    _interfaceSettings?.setValue(_kClockShowSeconds, value);
    notifyListeners();
  }

  bool? get clockShowWeekDay =>
      _interfaceSettings?.getValue(_kClockShowWeekDay);
  set clockShowWeekDay(bool? value) {
    if (value == null) return;
    _interfaceSettings?.setValue(_kClockShowWeekDay, value);
    notifyListeners();
  }

  bool? get calendarShowWeekNumber =>
      _calendarSettings?.getValue(_kCalendarShowWeekNumber);
  set calendarShowWeekNumber(bool? value) {
    if (value == null) return;
    _calendarSettings?.setValue(_kCalendarShowWeekNumber, value);
    notifyListeners();
  }
}
