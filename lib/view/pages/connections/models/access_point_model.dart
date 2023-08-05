part of 'wifi_model.dart';

enum ActiveConnectionState {
  unknown,
  activating,
  activated,
  deactivating,
  deactivated
}

class AccessPointModel extends PropertyStreamNotifier {

  AccessPointModel(
    this._networkManagerAccessPoint,
    this._networkManagerDeviceWireless,
  ) {
    addProperties(_networkManagerAccessPoint.propertiesChanged);
    addPropertyListener('Strength', notifyListeners);
  }
  final NetworkManagerAccessPoint _networkManagerAccessPoint;
  late final NetworkManagerDeviceWireless _networkManagerDeviceWireless;

  bool get isActive =>
      listEquals(_networkManagerDeviceWireless.activeAccessPoint?.ssid, ssid);

  List<int> get ssid => _networkManagerAccessPoint.ssid;

  String get name => String.fromCharCodes(ssid);

  bool get isLocked => _networkManagerAccessPoint.flags
      .contains(NetworkManagerWifiAccessPointFlag.privacy);

  WifiStrengthLevel get strengthLevel =>
      WifiStrengthLevelX.fromStrength(strength);

  int get strength => _networkManagerAccessPoint.strength;
}

enum WifiStrengthLevel {
  none,
  weak,
  ok,
  good,
  excellent,
}

extension WifiStrengthLevelX on WifiStrengthLevel {
  static WifiStrengthLevel fromStrength(int strength) {
    assert(strength >= 0 && strength <= 100);

    if (strength >= 0 && strength <= 20) return WifiStrengthLevel.none;
    if (strength > 20 && strength <= 40) return WifiStrengthLevel.weak;
    if (strength > 40 && strength < 60) return WifiStrengthLevel.ok;
    if (strength > 60 && strength <= 80) return WifiStrengthLevel.good;
    return WifiStrengthLevel.excellent;
  }
}
