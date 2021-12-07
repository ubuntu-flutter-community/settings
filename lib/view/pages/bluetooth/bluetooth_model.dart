import 'dart:async';

import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  final BlueZClient _client;

  late StreamSubscription<BlueZDevice>? _devicesAdded;
  late StreamSubscription<BlueZDevice>? _devicesRemoved;
  late BlueZAdapter? firstAdapter;

  BluetoothModel(this._client);

  void init() async {
    await _client.connect().then((value) {
      if (_client.adapters.isEmpty) {
        _client.close();
        return;
      }
      firstAdapter = _client.adapters[0];
      if (!firstAdapter!.discovering) {
        firstAdapter?.startDiscovery();
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
    if (firstAdapter!.discovering) {
      firstAdapter?.stopDiscovery();
    }
    _devicesAdded?.cancel();
    _devicesRemoved?.cancel();
    super.dispose();
  }
}
