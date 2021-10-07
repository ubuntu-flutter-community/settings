import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/power_profile_service.dart';

export 'package:settings/services/power_profile_service.dart' show PowerProfile;

class PowerProfileModel extends SafeChangeNotifier {
  PowerProfileModel(this._service);

  final PowerProfileService _service;
  StreamSubscription<PowerProfile?>? _subscription;

  void init() {
    _service.init().then((_) {
      _subscription = _service.profileChanged.listen((_) {
        notifyListeners();
      });
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  PowerProfile? get profile => _service.profile;
  void setProfile(PowerProfile? profile) => _service.setProfile(profile);
}
