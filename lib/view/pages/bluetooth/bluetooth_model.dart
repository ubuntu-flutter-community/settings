import 'package:bluez/bluez.dart';
import 'package:settings/view/pages/connections/models/property_stream_notifier.dart';

class BluetoothModel extends PropertyStreamNotifier {
  late final BlueZClient _client;

  BluetoothModel(this._client);

  Future<List<BlueZDevice>> get devices async {
    await _client.connect();
    return _client.devices;
  }

  void startScan() async {
    await _client.connect().then((value) {
      for (var adapter in _client.adapters) {
        adapter.startDiscovery();
      }
    });
  }

  void stopScan() async {
    for (var adapter in _client.adapters) {
      await adapter.stopDiscovery();
    }
  }

  @override
  void dispose() async {
    stopScan();
    await _client.close();
    super.dispose();
  }

  Stream<BlueZDevice> devicesAdded() {
    Stream<BlueZDevice> deviceStream = _client.deviceAdded;
    return deviceStream;
  }
}
