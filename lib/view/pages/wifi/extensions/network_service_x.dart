import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:nm/nm.dart';

extension NetworkManagerSettingsConnectionX
    on NetworkManagerSettingsConnection {
  Future<List<int>> get ssid async {
    final settings = await getSettings();
    final ssidDbusArray = settings['802-11-wireless']?['ssid'] as DBusArray?;
    final ssidBytes =
        ssidDbusArray?.children.map((c) => (c as DBusByte).value).toList() ??
            <int>[];

    return ssidBytes;
  }

  Future<String> get name async {
    /// get the connection name from settings instead
    final ssid = await this.ssid;
    return String.fromCharCodes(ssid);
  }

  Future<String> get hwAddress async {
    final settings = await getSettings();
    final bssidDbusArray =
        settings['802-11-wireless']?['seen-bssids'] as DBusArray?;

    final bssid = (bssidDbusArray?.children[0] as DBusString?)?.value;

    return bssid ?? '';
  }
}

extension NetworkManagerClientX on NetworkManagerClient {
  Future<NetworkManagerSettingsConnection> addWirelessConnection({
    required List<int> ssid,
    String? bssid,
    bool private = false,
    bool hidden = false,
    String? password,
  }) async {
    final properties = <String, Map<String, DBusValue>>{
      'connection': <String, DBusValue>{
        'id': DBusString(String.fromCharCodes(ssid)),
        if (private) 'user': DBusString(Platform.environment['USERNAME'] ?? ''),
      },
      '802-11-wireless': <String, DBusValue>{
        'ssid': DBusArray.byte(ssid),
        if (hidden) 'hidden': DBusBoolean(hidden),
        if (bssid != null) 'bssid': DBusString(bssid),
      },
      if (password != null)
        '802-11-wireless-security': <String, DBusValue>{
          'key-mgmt': const DBusString('wpa-psk'),
          'auth-alg': const DBusString('open'),
          'psk': DBusString(password),
        },
    };
    return settings.addConnection(properties);
  }

  Future<NetworkManagerSettingsConnection?> findConnectionFor(
    NetworkManagerAccessPoint accessPoint,
    NetworkManagerDevice wifiDevice,
  ) async {
    for (final connection in wifiDevice.availableConnections) {
      final connectionSsid = await connection.ssid;
      final connectionHwAddress = await connection.hwAddress;

      final accessPointSsid = accessPoint.ssid;
      final accessPointHwAddress = accessPoint.hwAddress;

      final areSameSsid = listEquals(connectionSsid, accessPointSsid);
      final areSameHwAddress = connectionHwAddress == accessPointHwAddress;

      if (areSameSsid && areSameHwAddress) return connection;
    }
    return null;
  }
}
