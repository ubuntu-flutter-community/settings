import 'package:bluez/bluez.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class BluetoothDeviceModel extends SafeChangeNotifier {
  final BlueZDevice _device;
  late bool connected;
  late String name;
  late int appearance;
  late int deviceClass;
  late String alias;
  late bool blocked;
  late String address;
  late bool paired;
  late String errorMessage;

  BluetoothDeviceModel(this._device) {
    connected = _device.connected;
    name = _device.name;
    appearance = _device.appearance;
    deviceClass = _device.deviceClass;
    alias = _device.alias;
    blocked = _device.blocked;
    address = _device.address;
    paired = _device.paired;
    errorMessage = '';
  }

  void init() {
    _device.propertiesChanged.listen((event) {
      connected = _device.connected;
      name = _device.name;
      appearance = _device.appearance;
      alias = _device.alias;
      blocked = _device.blocked;
      address = _device.address;
      paired = _device.paired;
      notifyListeners();
    });
  }

  Future<void> connect() async {
    if (!_device.paired) {
      await _device.pair().catchError((ioError) {
        errorMessage = ioError.toString();
      });
      notifyListeners();
    }

    await _device.connect().catchError((ioError) {
      errorMessage = ioError.toString();
    });
    paired = _device.paired;
    connected = _device.connected;
    notifyListeners();
  }

  Future<void> disconnect() async {
    await _device.disconnect();
    connected = _device.connected;
    notifyListeners();
  }
}
