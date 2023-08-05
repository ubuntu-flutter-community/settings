part of 'wifi_model.dart';

class WifiDeviceModel extends PropertyStreamNotifier {
  WifiDeviceModel(this._networkManagerDevice) {
    _networkManagerDeviceWireless = _networkManagerDevice.wireless!;

    addProperties(_networkManagerDeviceWireless.propertiesChanged);
    addPropertyListener('AccessPoints', notifyListeners);
    addPropertyListener('ActiveAccessPoint', notifyListeners);
    addPropertyListener('LastScan', notifyListeners);
  }
  final NetworkManagerDevice _networkManagerDevice;
  late final NetworkManagerDeviceWireless _networkManagerDeviceWireless;

  List<AccessPointModel> get accesPoints {
    final acceptedAccessPoints = <NetworkManagerAccessPoint>[];

    /// filter duplicate access points
    // ignore: prefer_function_declarations_over_variables
    final isAccessPointAlreadyAdded = (newAP) {
      return acceptedAccessPoints.any(
        (ap) =>
            // ap.hwAddress == newAP.hwAddress  &&
            listEquals(ap.ssid, newAP.ssid),
      );
    };

    // filter hidden or empyty SSIDs
    // ignore: prefer_function_declarations_over_variables
    final hasSsid = (ssid) {
      return ssid.isNotEmpty || String.fromCharCodes(ssid).trim().isNotEmpty;
    };

    // ignore: prefer_function_declarations_over_variables
    final isAccessPointAccepted = (accessPoint) {
      if (hasSsid(accessPoint.ssid) &&
          !isAccessPointAlreadyAdded(accessPoint)) {
        acceptedAccessPoints.add(accessPoint);
        return true;
      }
      return false;
    };

    return _networkManagerDeviceWireless.accessPoints
        .where(isAccessPointAccepted)
        .map(
          (networkManagerAccessPoint) => AccessPointModel(
            networkManagerAccessPoint,
            _networkManagerDeviceWireless,
          ),
        )
        .sorted((ap1, ap2) => ap2.strength.compareTo(ap1.strength));
  }

  String get driverName => _networkManagerDevice.driver;
  String get interface => _networkManagerDevice.interface;
}
