import 'package:nm/nm.dart';

import 'property_stream_notifier.dart';

part 'access_point_model.dart';
part 'wifi_adaptor_model.dart';

class WifiModel extends PropertyStreamNotifier {
  final NetworkManagerClient _networkManagerClient;

  List<WifiAdaptorModel> get wifiAdaptors => _networkManagerClient.devices
      .where((device) => device.wireless != null)
      .map((device) => WifiAdaptorModel(device))
      .toList();

  bool get isWifiEnabled => _networkManagerClient.wirelessEnabled;

  bool get isWifiAdaptorAvailable =>
      _networkManagerClient.wirelessHardwareEnabled &&
      _networkManagerClient.networkingEnabled;

  WifiModel(this._networkManagerClient) {
    addProperties(_networkManagerClient.propertiesChanged);
    addPropertyListener('Devices', notifyListeners);
    addPropertyListener('WirelessEnabled', notifyListeners);
    addPropertyListener('WirelessHardwareEnabled', notifyListeners);
    addPropertyListener('NetworkingEnabled', notifyListeners);
  }

//FIXME: can't connect to the access point which is not in range but still some how listed in the Page
  void connectToAccesPoint(
    AccessPointModel accessPointModel,
    WifiAdaptorModel wifiAdaptorModel,
  ) async {
    if (accessPointModel.isActive) return;

    await _networkManagerClient.activateConnection(
      device: wifiAdaptorModel._networkManagerDevice,
      accessPoint: accessPointModel._networkManagerAccessPoint,
    );
  }

  Future<bool> toggleWifi(bool value) async {
    try {
      await _networkManagerClient.setWirelessEnabled(value);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
