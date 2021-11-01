import 'package:dbus/dbus.dart';
import 'package:nm/nm.dart';

import '../data/authentication.dart';
import '../extensions/network_service_x.dart';
import 'property_stream_notifier.dart';

part 'access_point_model.dart';
part 'wifi_device_model.dart';

typedef OnAuthenticate = Future<Authentication?> Function(
  WifiDeviceModel wifiAdaptor,
  AccessPointModel accessPoint,
);

class WifiModel extends PropertyStreamNotifier {
  final NetworkManagerClient _networkManagerClient;

  List<WifiDeviceModel> get wifiDevices => _networkManagerClient.devices
      .where((device) => device.wireless != null)
      .map((device) => WifiDeviceModel(device))
      .toList();

  bool get isWifiEnabled => _networkManagerClient.wirelessEnabled;

  bool get isWifiDeviceAvailable =>
      _networkManagerClient.wirelessHardwareEnabled &&
      _networkManagerClient.networkingEnabled;

  WifiModel(this._networkManagerClient) {
    addProperties(_networkManagerClient.propertiesChanged);
    addPropertyListener('Devices', notifyListeners);
    addPropertyListener('WirelessEnabled', notifyListeners);
    addPropertyListener('WirelessHardwareEnabled', notifyListeners);
    addPropertyListener('NetworkingEnabled', notifyListeners);
  }

  void connectToAccesPoint(
    AccessPointModel accessPointModel,
    WifiDeviceModel wifiAdaptorModel,
    OnAuthenticate onAuth,
  ) async {
    if (accessPointModel.isActive) return;

    try {
      var connection = await _networkManagerClient.findConnectionFor(
        accessPointModel._networkManagerAccessPoint,
        wifiAdaptorModel._networkManagerDevice,
      );
      if (connection == null) {
        Authentication? authentication;
        if (accessPointModel.isLocked) {
          authentication = await onAuth(
            wifiAdaptorModel,
            accessPointModel,
          );
          if (authentication == null) return;
        }
        connection = await _networkManagerClient.addWirelessConnection(
          ssid: accessPointModel.ssid.codeUnits,
          password: authentication?.password,
          private: authentication?.storePassword == StorePassword.thisUser,
        );
      }

      await _networkManagerClient.activateConnection(
        device: wifiAdaptorModel._networkManagerDevice,
        connection: connection,
        accessPoint: accessPointModel._networkManagerAccessPoint,
      );
    } on DBusMethodResponseException catch (e) {
      print(e.errorName);
    } on Exception catch (e) {
      print(e.toString());
    }
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
