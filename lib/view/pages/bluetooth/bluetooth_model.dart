import 'dart:async';

import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  final BlueZClient _client;

  StreamSubscription<BlueZDevice>? _devicesAdded;
  StreamSubscription<BlueZDevice>? _devicesRemoved;

  BluetoothModel(this._client);

  void init() async {
    await _client.connect().then((value) {
      if (_client.adapters.isEmpty) {
        _client.close();
        return;
      }
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
    }).onError((error, stackTrace) {
      _client.close();
      return;
    });
  }

  List<BlueZDevice> get devices {
    return _client.devices;
  }

  Future<void> removeDevice(BlueZDevice device) async {
    for (var adapter in _client.adapters) {
      await adapter.removeDevice(device);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var adapter in _client.adapters) {
      adapter.stopDiscovery();
    }
    _devicesAdded?.cancel();
    _devicesRemoved?.cancel();
    super.dispose();
  }
}
