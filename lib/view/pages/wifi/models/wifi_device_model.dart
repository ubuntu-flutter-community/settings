part of 'wifi_model.dart';

class WifiDeviceModel extends PropertyStreamNotifier {
  final NetworkManagerDevice _networkManagerDevice;
  late final NetworkManagerDeviceWireless _networkManagerDeviceWireless;

  List<AccessPointModel> get accesPoints =>
      _networkManagerDeviceWireless.accessPoints
          .where((element) => String.fromCharCodes(element.ssid).isNotEmpty)
          .map((networkManagerAccessPoint) => AccessPointModel(
                networkManagerAccessPoint,
                _networkManagerDeviceWireless,
              ))
          .toList()
        ..sort((a, b) => a.strength.compareTo(b.strength));

  String get driverName => _networkManagerDevice.driver;
  String get interface => _networkManagerDevice.interface;

  WifiDeviceModel(this._networkManagerDevice) {
    _networkManagerDeviceWireless = _networkManagerDevice.wireless!;

    addProperties(_networkManagerDeviceWireless.propertiesChanged);
    addPropertyListener('AccessPoints', notifyListeners);
    addPropertyListener('ActiveAccessPoint', notifyListeners);
    addPropertyListener('LastScan', notifyListeners);
  }
}
