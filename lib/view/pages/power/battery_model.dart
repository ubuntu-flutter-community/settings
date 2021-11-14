import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:upower/upower.dart';

export 'package:settings/services/power_profile_service.dart' show PowerProfile;

class BatteryModel extends SafeChangeNotifier {
  UPowerClient? _client;

  void init(UPowerClient client) {
    client.connect().then((_) {
      _client = client;
      notifyListeners();
    });
  }

  UPowerDevice? get _device => _client?.displayDevice;

  UPowerDeviceState? get state => _device?.state;
  double get percentage => _device?.percentage ?? 0;
  int get timeToEmpty => _device?.timeToEmpty ?? 0;
  int get timeToFull => _device?.timeToFull ?? 0;
}
