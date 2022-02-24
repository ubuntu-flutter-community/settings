import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/date_time_service.dart';
import 'package:settings/services/settings_service.dart';

// org.gnome.desktop.datetime automatic-timezone false
// org.gnome.desktop.interface clock-format '24h'
// org.gnome.desktop.interface clock-show-weekday true
const _kAutomaticTimezone = 'automatic-timezone';
const _kClockFormat = 'clock-format';

class DateTimeModel extends SafeChangeNotifier {
  final Settings? _dateTimeSettings;
  final Settings? _interfaceSettings;
  final DateTimeService _dateTimeService;
  StreamSubscription<String?>? _timezoneSub;
  StreamSubscription<DateTime?>? _dateTimeSub;

  DateTimeModel(
      {required DateTimeService dateTimeService,
      required SettingsService settingsService})
      : _dateTimeService = dateTimeService,
        _dateTimeSettings = settingsService.lookup(schemaDateTime),
        _interfaceSettings = settingsService.lookup(schemaInterface) {
    _dateTimeSettings?.addListener(notifyListeners);
    _interfaceSettings?.addListener(notifyListeners);
  }

  Future<void> init() {
    return _dateTimeService.init().then((_) {
      _timezoneSub = _dateTimeService.timezoneChanged.listen((_) {
        notifyListeners();
      });
      _dateTimeSub = _dateTimeService.dateTimeChanged.listen((_) {
        notifyListeners();
      });
      notifyListeners();
    });
  }

  @override
  Future<void> dispose() async {
    await _timezoneSub?.cancel();
    await _dateTimeSub?.cancel();
    _dateTimeSettings?.dispose();
    _interfaceSettings?.dispose();
    super.dispose();
  }

  String? get timezone => _dateTimeService.timezone;
  DateTime? get dateTime => _dateTimeService.dateTime;

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

  bool? get clockIsTwentyFourFormat => _clockFormat == '24h';
  set clockIsTwentyFourFormat(bool? value) {
    if (value == null) return;
    _clockFormat = value ? '24h' : '12h';
  }
}
