import 'package:dbus/dbus.dart';
import 'package:settings/services/display/objects/dbus_displays_config.dart';
import 'package:settings/generated/dbus/display-config-remote-object.dart';

const _displaysInterface = 'org.gnome.Mutter.DisplayConfig';

const _displayPath = '/org/gnome/Mutter/DisplayConfig';

///
/// Methods:
///
/// ApplyConfiguration (UInt32 serial, Boolean persistent, Array of [Struct of (UInt32, Int32, Int32, Int32, UInt32, Array of [UInt32], Dict of {String, Variant})] crtcs, Array of [Struct of (UInt32, Dict of {String, Variant})] outputs) ↦ ()
/// ApplyMonitorsConfig (UInt32 serial, UInt32 method, Array of [Struct of (Int32, Int32, Double, UInt32, Boolean, Array of [Struct of (String, String, Dict of {String, Variant})])] logical_monitors, Dict of {String, Variant} properties) ↦ ()
/// ChangeBacklight (UInt32 serial, UInt32 output, Int32 value) ↦ (Int32 new_value)
/// GetCrtcGamma (UInt32 serial, UInt32 crtc) ↦ (Array of [UInt16] red, Array of [UInt16] green, Array of [UInt16] blue)
/// GetCurrentState () ↦ (UInt32 serial, Array of [Struct of (Struct of (String, String, String, String), Array of [Struct of (String, Int32, Int32, Double, Double, Array of [Double], Dict of {String, Variant})], Dict of {String, Variant})] monitors, Array of [Struct of (Int32, Int32, Double, UInt32, Boolean, Array of [Struct of (String, String, String, String)], Dict of {String, Variant})] logical_monitors, Dict of {String, Variant} properties)
/// GetResources () ↦ (UInt32 serial, Array of [Struct of (UInt32, Int64, Int32, Int32, Int32, Int32, Int32, UInt32, Array of [UInt32], Dict of {String, Variant})] crtcs, Array of [Struct of (UInt32, Int64, Int32, Array of [UInt32], String, Array of [UInt32], Array of [UInt32], Dict of {String, Variant})] outputs, Array of [Struct of (UInt32, Int64, UInt32, UInt32, Double, UInt32)] modes, Int32 max_screen_width, Int32 max_screen_height)
/// SetCrtcGamma (UInt32 serial, UInt32 crtc, Array of [UInt16] red, Array of [UInt16] green, Array of [UInt16] blue) ↦ ()
/// SetOutputCTM (UInt32 serial, UInt32 output, Struct of (UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64) ctm) ↦ ()
///
/// Signals:
///
/// MonitorsChanged
class DisplayDBusService {
  DisplayDBusService() : _object = _createObject() {
    /// Listen to signal stream, when a change occur, we update our data
    _object.monitorsChanged
        .listen((OrgGnomeMutterDisplayConfigMonitorsChanged signal) {
      if (signal.name == 'MonitorsChanged') {
        getCurrent();
      }
    });
  }

  final OrgGnomeMutterDisplayConfig _object;

  Stream<DBusDisplaysConfig> get streamChanges =>
      _object.monitorsChanged.asyncMap((event) async => getCurrent());

  static OrgGnomeMutterDisplayConfig _createObject() =>
      OrgGnomeMutterDisplayConfig(
        DBusClient.session(),
        _displaysInterface,
        DBusObjectPath(_displayPath),
      );

  Future<void> dispose() async {
    await _object.client.close();
  }

  Future<DBusDisplaysConfig> getCurrent() async {
    List<DBusValue>? state = await _object.callGetCurrentState();
    List<dynamic> list = state.map((e) => _toNative(e)).toList();
    return DBusDisplaysConfig(list);
  }

  Future<void> apply(
    int serial,
    ConfigurationMethod configurationMethod,
    List<DBusStruct> logicalParameterValues,
  ) =>
      _object.callApplyMonitorsConfig(
        serial,
        configurationMethod.index,
        logicalParameterValues,
        {},
      );

  dynamic _toNative(dynamic value) {
    dynamic output;

    if (value is Map) {
      output =
          value.map((key, value) => MapEntry(_toNative(key), _toNative(value)));
    } else if (value is Iterable) {
      output = value.map((e) => _toNative(e)).toList();
    } else if (value is DBusArray) {
      output = value.toNative().map((e) => _toNative(e)).toList();
    } else if (value is DBusValue) {
      output = value.toNative();
    } else {
      return value;
    }

    return output;
  }
}

enum ConfigurationMethod { verify, temporary, persistent }
