import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/date_time_service.dart';
import 'package:settings/services/settings_service.dart';

const _kAutomaticTimezone = 'automatic-timezone';
const _kClockFormat = 'clock-format';

class DateTimeModel extends SafeChangeNotifier {
  final Settings? _dateTimeSettings;
  final Settings? _interfaceSettings;
  final DateTimeService _dateTimeService;
  StreamSubscription<String?>? _timezoneSub;
  Timer? _fetchDateTimeTimer;
  DateTime? _dateTime;

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
      _dateTime = _dateTimeService.dateTime;
      notifyListeners();

      _fetchDateTimeTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          _dateTime = await getDateTime();
          notifyListeners();
        },
      );
    });
  }

  @override
  Future<void> dispose() async {
    _fetchDateTimeTimer!.cancel();
    await _timezoneSub?.cancel();
    _dateTimeSettings?.dispose();
    _interfaceSettings?.dispose();
    super.dispose();
  }

  String? get timezone => _dateTimeService.timezone;
  DateTime? get dateTime => _dateTime;
  Future<DateTime?> getDateTime() async => await _dateTimeService.getDateTime();

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
