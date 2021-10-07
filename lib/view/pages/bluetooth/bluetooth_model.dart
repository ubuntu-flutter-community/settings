import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothModel extends SafeChangeNotifier {
  late BlueZClient client;

  BluetoothModel({required this.client});

  void init() {
    client.connect().then((_) {
      notifyListeners();
    });
  }

  List<BlueZDevice> get devices => client.devices;
}
