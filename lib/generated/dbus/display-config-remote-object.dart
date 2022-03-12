// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object interfaces/org.gnome.Mutter.DisplayConfig.xml

import 'package:dbus/dbus.dart';

/// Signal data for org.gnome.Mutter.DisplayConfig.MonitorsChanged.
class OrgGnomeMutterDisplayConfigMonitorsChanged extends DBusSignal {
  OrgGnomeMutterDisplayConfigMonitorsChanged(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgGnomeMutterDisplayConfig extends DBusRemoteObject {
  /// Stream of org.gnome.Mutter.DisplayConfig.MonitorsChanged signals.
  late final Stream<OrgGnomeMutterDisplayConfigMonitorsChanged> monitorsChanged;

  OrgGnomeMutterDisplayConfig(DBusClient client, String destination, DBusObjectPath path) : super(client, name: destination, path: path) {
    monitorsChanged = DBusRemoteObjectSignalStream(object: this, interface: 'org.gnome.Mutter.DisplayConfig', name: 'MonitorsChanged', signature: DBusSignature('')).asBroadcastStream().map((signal) => OrgGnomeMutterDisplayConfigMonitorsChanged(signal));
  }

  /// Gets org.gnome.Mutter.DisplayConfig.PowerSaveMode
  Future<int> getPowerSaveMode() async {
    var value = await getProperty('org.gnome.Mutter.DisplayConfig', 'PowerSaveMode', signature: DBusSignature('i'));
    return (value as DBusInt32).value;
  }

  /// Sets org.gnome.Mutter.DisplayConfig.PowerSaveMode
  Future<void> setPowerSaveMode (int value) async {
    await setProperty('org.gnome.Mutter.DisplayConfig', 'PowerSaveMode', DBusInt32(value));
  }

  /// Gets org.gnome.Mutter.DisplayConfig.PanelOrientationManaged
  Future<bool> getPanelOrientationManaged() async {
    var value = await getProperty('org.gnome.Mutter.DisplayConfig', 'PanelOrientationManaged', signature: DBusSignature('b'));
    return (value as DBusBoolean).value;
  }

  /// Gets org.gnome.Mutter.DisplayConfig.ApplyMonitorsConfigAllowed
  Future<bool> getApplyMonitorsConfigAllowed() async {
    var value = await getProperty('org.gnome.Mutter.DisplayConfig', 'ApplyMonitorsConfigAllowed', signature: DBusSignature('b'));
    return (value as DBusBoolean).value;
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.GetResources()
  Future<List<DBusValue>> callGetResources({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.Mutter.DisplayConfig', 'GetResources', [], replySignature: DBusSignature('ua(uxiiiiiuaua{sv})a(uxiausauaua{sv})a(uxuudu)ii'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.ApplyConfiguration()
  Future<void> callApplyConfiguration(int serial, bool persistent, List<DBusStruct> crtcs, List<DBusStruct> outputs, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.gnome.Mutter.DisplayConfig', 'ApplyConfiguration', [DBusUint32(serial), DBusBoolean(persistent), DBusArray(DBusSignature('(uiiiuaua{sv})'), crtcs.map((child) => child)), DBusArray(DBusSignature('(ua{sv})'), outputs.map((child) => child))], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.ChangeBacklight()
  Future<int> callChangeBacklight(int serial, int output, int value, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.Mutter.DisplayConfig', 'ChangeBacklight', [DBusUint32(serial), DBusUint32(output), DBusInt32(value)], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return (result.returnValues[0] as DBusInt32).value;
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.GetCrtcGamma()
  Future<List<DBusValue>> callGetCrtcGamma(int serial, int crtc, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.Mutter.DisplayConfig', 'GetCrtcGamma', [DBusUint32(serial), DBusUint32(crtc)], replySignature: DBusSignature('aqaqaq'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.SetCrtcGamma()
  Future<void> callSetCrtcGamma(int serial, int crtc, List<int> red, List<int> green, List<int> blue, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.gnome.Mutter.DisplayConfig', 'SetCrtcGamma', [DBusUint32(serial), DBusUint32(crtc), DBusArray.uint16(red), DBusArray.uint16(green), DBusArray.uint16(blue)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.GetCurrentState()
  Future<List<DBusValue>> callGetCurrentState({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.Mutter.DisplayConfig', 'GetCurrentState', [], replySignature: DBusSignature('ua((ssss)a(siiddada{sv})a{sv})a(iiduba(ssss)a{sv})a{sv}'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.ApplyMonitorsConfig()
  Future<void> callApplyMonitorsConfig(int serial, int method, List<DBusStruct> logical_monitors, Map<String, DBusValue> properties, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.gnome.Mutter.DisplayConfig', 'ApplyMonitorsConfig', [DBusUint32(serial), DBusUint32(method), DBusArray(DBusSignature('(iiduba(ssa{sv}))'), logical_monitors.map((child) => child)), DBusDict.stringVariant(properties)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.gnome.Mutter.DisplayConfig.SetOutputCTM()
  Future<void> callSetOutputCTM(int serial, int output, DBusStruct ctm, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.gnome.Mutter.DisplayConfig', 'SetOutputCTM', [DBusUint32(serial), DBusUint32(output), ctm], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}
