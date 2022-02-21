import 'dart:async';

import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  final BlueZClient _client;

  StreamSubscription<BlueZDevice>? _devicesAdded;
  StreamSubscription<BlueZDevice>? _devicesRemoved;
  StreamSubscription<BlueZAdapter>? _adaptersRemoved;
  StreamSubscription<BlueZAdapter>? _adaptersAdded;

  BluetoothModel(this._client);

  bool get discovering {
    for (var adapter in _client.adapters) {
      if (adapter.discovering) {
        return true;
      }
    }
    return false;
  }

  void startDiscovery() {
    for (var adapter in _client.adapters) {
      if (!adapter.discovering && adapter.powered) {
        adapter.startDiscovery();
      }
      notifyListeners();
    }
  }

  void stopDiscovery() {
    for (var adapter in _client.adapters) {
      if (adapter.discovering && adapter.powered) {
        adapter.stopDiscovery();
      }
      notifyListeners();
    }
  }

  bool get powered {
    for (var adapter in _client.adapters) {
      return adapter.powered;
    }
    return false;
  }

  void setPowered(bool value) async {
    for (var adapter in _client.adapters) {
      await adapter.setPowered(value);
    }
    notifyListeners();
  }

  void init() async {
    await _client.connect().then((value) {
      if (_client.adapters.isEmpty) {
        _client.close();
        return;
      }

      _devicesAdded = _client.deviceAdded.listen((event) {
        notifyListeners();
      });
      _devicesRemoved = _client.deviceRemoved.listen((event) {
        notifyListeners();
      });
      _adaptersAdded = _client.adapterAdded.listen((event) {
        notifyListeners();
      });
      _adaptersRemoved = _client.adapterRemoved.listen((event) {
        notifyListeners();
      });
      for (var adapter in _client.adapters) {
        if (!adapter.discovering && adapter.powered) {
          adapter.startDiscovery();
          notifyListeners();
        }
      }
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
      if (adapter.discovering && adapter.powered) {
        adapter.stopDiscovery();
      }
    }
    _devicesAdded?.cancel();
    _devicesRemoved?.cancel();
    _adaptersAdded?.cancel();
    _adaptersRemoved?.cancel();
    super.dispose();
  }
}
