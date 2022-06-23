import 'dart:async';
import 'dart:io';

import 'package:dbus/dbus.dart';

const _kLocaleInterfaceName = 'org.freedesktop.locale1';
const _kLocaleInterfacePath = '/org/freedesktop/locale1';
const _kLocalePropertyName = 'Locale';
const _kSetLocaleMethodName = 'SetLocale';
const _kLocaleLocation = '/usr/share/i18n/SUPPORTED';

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

  List<String?>? _locales;
  List<String?>? get locales => _locales;

  static DBusRemoteObject _createObject() => DBusRemoteObject(
        DBusClient.system(),
        name: _kLocaleInterfaceName,
        path: DBusObjectPath(_kLocaleInterfacePath),
      );

  Future<void> init() async {
    _locales = await _getLocales();
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

  Future<List<String?>?> _getLocales() async {
    return await File(_kLocaleLocation).readAsLines();
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
    if (value == null) return;
    final children = <DBusString>[];
    for (var string in value) {
      if (string != null) {
        children.add(DBusString(string));
      }
    }
    final array = DBusArray(DBusSignature('s'), children);
    final args = [array, const DBusBoolean(false)];
    callMethod(_kLocaleInterfaceName, _kSetLocaleMethodName, args);
  }
}

extension _ChangedLocale on DBusPropertiesChangedSignal {
  bool hasChangedLocale() =>
      changedProperties.containsKey(_kLocalePropertyName);
}
