import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  late BlueZClient client;

  BluetoothModel({required this.client});

  Future<List<BlueZDevice>> get devices async {
    await client.connect();
    return client.devices;
  }

  Stream<BlueZDevice> deviceStream() {
    Stream<BlueZDevice> deviceStream = client.deviceAdded;

    return deviceStream;
  }
}
