part of 'wifi_model.dart';

class AccessPointModel extends PropertyStreamNotifier {
  final NetworkManagerAccessPoint _networkManagerAccessPoint;
  late final NetworkManagerDeviceWireless _networkManagerDeviceWireless;

  bool get isActive =>
      _networkManagerDeviceWireless.activeAccessPoint?.hwAddress ==
      _networkManagerAccessPoint.hwAddress;

  String get ssid => String.fromCharCodes(_networkManagerAccessPoint.ssid);

  bool get isLocked => _networkManagerAccessPoint.flags
      .contains(NetworkManagerWifiAccessPointFlag.privacy);

  WifiStrengthLevel get strengthLevel =>
      WifiStrengthLevelX.fromStrength(_networkManagerAccessPoint.strength);

  AccessPointModel(
    this._networkManagerAccessPoint,
    this._networkManagerDeviceWireless,
  ) {
    addProperties(_networkManagerAccessPoint.propertiesChanged);
    addPropertyListener('Strength', notifyListeners);
  }
}

enum WifiStrengthLevel {
  veryLow,
  low,
  medium,
  high,
  veryHigh,
}

extension WifiStrengthLevelX on WifiStrengthLevel {
  static WifiStrengthLevel fromStrength(int strength) {
    assert(strength >= 0 && strength <= 100);

    if (strength >= 0 && strength <= 20) return WifiStrengthLevel.veryLow;
    if (strength > 20 && strength <= 40) return WifiStrengthLevel.low;
    if (strength > 40 && strength < 60) return WifiStrengthLevel.medium;
    if (strength > 60 && strength <= 80) return WifiStrengthLevel.high;
    return WifiStrengthLevel.veryHigh;
  }
}
