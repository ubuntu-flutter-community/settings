import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  late final BlueZClient _client;

  BluetoothModel(this._client);

  void init() async {
    await _client.connect().then((value) {
      for (var adapter in _client.adapters) {
        adapter.startDiscovery();
      }
    });
  }

  List<BlueZDevice> get devices {
    _client.deviceAdded.listen((event) {
      notifyListeners();
    });
    return _client.devices;
  }
}
