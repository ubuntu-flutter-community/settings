// org.freedesktop.locale1

// Method: SetLocale (Array of [String] locale, Boolean interactive) ↦ ()
// Property: Locale Array of [String]

import 'package:dbus/dbus.dart';

const _kLocaleInterfaceName = 'org.freedesktop.locale1';
const _kLocaleInterfacePath = '/org/freedesktop/locale1';
const _kLocalePropertyName = 'Locale';
const _kSetLocaleMethodName = 'SetLocale';

class LocaleService {}

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
