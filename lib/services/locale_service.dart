import 'dart:async';

import 'package:dbus/dbus.dart';

const _kLocaleInterfaceName = 'org.freedesktop.locale1';
const _kLocaleInterfacePath = '/org/freedesktop/locale1';
const _kLocalePropertyName = 'Locale';
const _kSetLocaleMethodName = 'SetLocale';

class LocaleService {
  LocaleService() : _object = _createObject();
  final DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;
  List<String?>? _locale;
  List<String?>? get locale => _locale;
  set locale(List<String?>? locale) {
    if (locale == _locale) return;
    _object.setLocale(locale);
  }

  static DBusRemoteObject _createObject() =>
      DBusRemoteObject(DBusClient.system(),
          name: _kLocaleInterfaceName,
          path: DBusObjectPath(_kLocaleInterfacePath));

  Future<void> init() async {
    await _initLocale();
    _propertyListener ??= _object.propertiesChanged.listen(_updateProperties);
  }

  void _updateProperties(DBusPropertiesChangedSignal signal) {
    if (signal.hasChangedLocale()) {
      _object.getLocale().then(_updateLocale);
    }
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await _object.client.close();
    _propertyListener = null;
  }

  Stream<List<String?>?> get localeChanged => _localeController.stream;
  final _localeController = StreamController<List<String?>?>.broadcast();

  void _updateLocale(List<String?>? value) {
    if (_locale == value) return;
    _locale = value;
    if (!_localeController.isClosed) {
      _localeController.add(_locale);
    }
  }

  Future<void> _initLocale() async {
    _updateLocale(await _object.getLocale());
  }
}

extension _LocaleRemoteObject on DBusRemoteObject {
  Future<List<String?>?> getLocale() async {
    final locale =
        await getProperty(_kLocaleInterfaceName, _kLocalePropertyName);
    return (locale as DBusArray)
        .children
        .map((string) => (string as DBusString).value)
        .toList();
  }

  Future<void> setLocale(List<String?>? value) async {
    final args = [
      DBusArray(DBusSignature('as')),
      [for (var item in value ?? []) DBusString(item)]
    ];
    callMethod(
        _kLocaleInterfaceName, _kSetLocaleMethodName, args as List<DBusValue>);
  }
}

extension _ChangedLocale on DBusPropertiesChangedSignal {
  bool hasChangedLocale() =>
      changedProperties.containsKey(_kLocalePropertyName);
}
