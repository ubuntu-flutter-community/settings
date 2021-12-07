import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothDeviceModel extends SafeChangeNotifier {
  final BlueZDevice device;

  BluetoothDeviceModel({required this.device});

  Future<void> connect() async {
    await device.connect();
    notifyListeners();
  }

  Future<void> disconnect() async {
    await device.disconnect();
    notifyListeners();
  }
}
