import 'dart:async';

import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  final BlueZClient _client;

  late StreamSubscription<BlueZDevice>? _devicesAdded;
  late StreamSubscription<BlueZDevice>? _devicesRemoved;

  BluetoothModel(this._client);

  void init() async {
    await _client.connect().then((value) {
      for (var adapter in _client.adapters) {
        adapter.startDiscovery();
      }
      _devicesAdded = _client.deviceAdded.listen((event) {
        notifyListeners();
      });
      _devicesRemoved = _client.deviceRemoved.listen((event) {
        notifyListeners();
      });
      notifyListeners();
    });
  }

  List<BlueZDevice> get devices {
    return _client.devices;
  }

  void removeDevice(BlueZDevice device) {
    for (var adapter in _client.adapters) {
      adapter.removeDevice(device);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    for (var adapter in _client.adapters) {
      adapter.stopDiscovery();
    }
    _devicesAdded!.cancel();
    _devicesRemoved!.cancel();
    super.dispose();
  }
}
