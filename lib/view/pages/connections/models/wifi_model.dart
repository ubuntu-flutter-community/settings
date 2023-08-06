import 'package:dbus/dbus.dart';
import 'package:nm/nm.dart';
import 'package:settings/view/pages/connections/data/authentication.dart';
import 'package:settings/view/pages/connections/extensions/network_service_x.dart';
import 'package:settings/view/pages/connections/models/access_point_model.dart';
import 'package:settings/view/pages/connections/models/property_stream_notifier.dart';
import 'package:settings/view/pages/connections/models/wifi_device_model.dart';

class WifiModel extends PropertyStreamNotifier {
  WifiModel(this._networkManagerClient) {
    addProperties(_networkManagerClient.propertiesChanged);
    addPropertyListener('Devices', notifyListeners);
    addPropertyListener('WirelessEnabled', notifyListeners);
    addPropertyListener('WirelessHardwareEnabled', notifyListeners);
    addPropertyListener('NetworkingEnabled', notifyListeners);
  }
  final NetworkManagerClient _networkManagerClient;

  List<WifiDeviceModel> get wifiDevices => _networkManagerClient.devices
      .where((device) => device.wireless != null)
      .map(WifiDeviceModel.new)
      .toList();

  bool get isWifiEnabled => _networkManagerClient.wirelessEnabled;

  bool get isWifiDeviceAvailable =>
      _networkManagerClient.wirelessHardwareEnabled &&
      _networkManagerClient.networkingEnabled;

  String _errorMessage = '';
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  void connectToAccesPoint(
    AccessPointModel accessPointModel,
    WifiDeviceModel wifiAdaptorModel,
    Future<Authentication?> Function(
      WifiDeviceModel wifiAdaptor,
      AccessPointModel accessPoint,
    ) onAuth,
  ) async {
    if (accessPointModel.isActive) return;

    try {
      var connection = await _networkManagerClient.findConnectionFor(
        accessPointModel.networkManagerAccessPoint,
        wifiAdaptorModel.networkManagerDevice,
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
          ssid: accessPointModel.ssid,
          password: authentication?.password,
          private: authentication?.storePassword == StorePassword.thisUser,
        );
      }

      await _networkManagerClient.activateConnection(
        device: wifiAdaptorModel.networkManagerDevice,
        connection: connection,
        accessPoint: accessPointModel.networkManagerAccessPoint,
      );
    } on DBusMethodResponseException catch (e) {
      errorMessage = e.toString();
    } on Exception catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<bool> toggleWifi(bool value) async {
    try {
      await _networkManagerClient.setWirelessEnabled(value);
      return true;
    } on Exception catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
}
