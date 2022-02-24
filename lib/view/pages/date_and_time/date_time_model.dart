import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/date_time_service.dart';

class DateTimeModel extends SafeChangeNotifier {
  final DateTimeService _service;
  StreamSubscription<String?>? _timezoneSub;

  DateTimeModel({required DateTimeService service}) : _service = service;

  Future<void> init() {
    final timezoneFutue = _service.init().then((_) {
      _timezoneSub = _service.timezoneChanged.listen((_) {
        notifyListeners();
      });
      notifyListeners();
    });

    return Future.wait([timezoneFutue]);
  }

  @override
  Future<void> dispose() async {
    await _timezoneSub?.cancel();
    super.dispose();
  }

  String? get timezone => _service.timezone;
}
