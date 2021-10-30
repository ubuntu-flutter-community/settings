part of 'wifi_model.dart';

class WifiAdaptorModel extends PropertyStreamNotifier {
  final NetworkManagerDevice _networkManagerDevice;
  late final NetworkManagerDeviceWireless _networkManagerDeviceWireless;

  List<AccessPointModel> get accesPoints =>
      _networkManagerDeviceWireless.accessPoints
          .where((element) => String.fromCharCodes(element.ssid).isNotEmpty)
          .map((networkManagerAccessPoint) => AccessPointModel(
                networkManagerAccessPoint,
                _networkManagerDeviceWireless,
              ))
          .toList();

  String get driverName => _networkManagerDevice.driver;
  String get interface => _networkManagerDevice.interface;

  WifiAdaptorModel(this._networkManagerDevice) {
    _networkManagerDeviceWireless = _networkManagerDevice.wireless!;

    addProperties(_networkManagerDeviceWireless.propertiesChanged);
    addPropertyListener('AccessPoints', notifyListeners);
    addPropertyListener('ActiveAccessPoint', notifyListeners);
    addPropertyListener('LastScan', notifyListeners);
  }
}
