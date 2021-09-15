import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:meta/meta.dart';

@visibleForTesting
const kHostnameInterface = 'org.freedesktop.hostname1';

@visibleForTesting
const kHostnamePath = '/org/freedesktop/hostname1';

class HostnameService {
  HostnameService([@visibleForTesting DBusRemoteObject? object])
      : _object = object ?? _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.system(),
      name: kHostnameInterface,
      path: DBusObjectPath(kHostnamePath),
    );
  }

  Future<void> init() async {
    await _initProperties();
    _propertyListener = _object.propertiesChanged.listen(_updateProperties);
  }

  Future<void> dispose() async {
    await _hostnameController.close();
    await _staticHostnameController.close();
    await _propertyListener?.cancel();
    await _object.client.close();
  }

  late final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  var _hostname = '';
  var _prettyHostname = '';
  var _staticHostname = '';

  String get hostname => _prettyHostname.orIfEmpty(_hostname);
  Stream<String> get hostnameChanged => _hostnameController.stream;
  final _hostnameController = StreamController<String>();

  String get staticHostname => _staticHostname.orIfEmpty(_hostname.toStatic());
  Stream<String> get staticHostnameChanged => _staticHostnameController.stream;
  final _staticHostnameController = StreamController<String>();

  Future<void> setHostname(String hostname) async {
    await _object.setHostname('SetPrettyHostname', hostname);
    await _object.setHostname('SetStaticHostname', hostname.toStatic());
  }

  void _updateHostname({
    required String? hostname,
    required String? prettyHostname,
    required String? staticHostname,
  }) {
    _hostname = hostname ?? _hostname;
    _prettyHostname = prettyHostname ?? _prettyHostname;
    _staticHostname = staticHostname ?? _staticHostname;

    _hostnameController.add(this.hostname);
    _staticHostnameController.add(this.staticHostname);
  }

  Future<void> _initProperties() async {
    _updateHostname(
      hostname: await _object.getHostname('Hostname'),
      prettyHostname: await _object.getHostname('PrettyHostname'),
      staticHostname: await _object.getHostname('StaticHostname'),
    );
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    _updateHostname(
      hostname: signal.getChangedHostname('Hostname'),
      prettyHostname: signal.getChangedHostname('PrettyHostname'),
      staticHostname: signal.getChangedHostname('StaticHostname'),
    );
  }
}

extension _StaticHostname on String {
  String toStatic() {
    var hostname = replaceAll(RegExp('[^a-zA-Z0-9-]'), '-');
    while (hostname.startsWith('-')) {
      hostname = hostname.substring(1);
    }
    while (hostname.endsWith('-')) {
      hostname = hostname.substring(0, hostname.length - 1);
    }
    hostname = hostname.replaceAll(RegExp('-{2,}'), '-');
    return hostname.toLowerCase();
  }
}

extension _HostnameObject on DBusRemoteObject {
  Future<String> getHostname(String name) async {
    final value = await getProperty(kHostnameInterface, name);
    return (value as DBusString).value;
  }

  Future<void> setHostname(String method, String argument) {
    final args = [DBusString(argument), const DBusBoolean(false)];
    return callMethod(kHostnameInterface, method, args);
  }
}

extension _ChangedHostname on DBusPropertiesChangedSignal {
  String? getChangedHostname(String name) {
    return (changedProperties[name] as DBusString?)?.value;
  }
}

extension _StringOrIfEmpty on String {
  String orIfEmpty(String another) => isEmpty ? another : this;
}
