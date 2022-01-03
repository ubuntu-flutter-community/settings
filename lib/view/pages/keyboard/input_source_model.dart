import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class InputSourceModel extends SafeChangeNotifier {
  final Settings? _inputSourceSettings;
  static const _perWindowKey = 'per-window';
  static const _sourcesKey = 'sources';
  static const _mruSourcesKey = 'mru-sources';

  InputSourceModel(SettingsService service)
      : _inputSourceSettings = service.lookup(schemaInputSources) {
    _inputSourceSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _inputSourceSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool get perWindow => _inputSourceSettings?.getValue(_perWindowKey) ?? false;

  set perWindow(bool value) {
    _inputSourceSettings?.setValue(_perWindowKey, value);
    notifyListeners();
  }

  Future<List<String>?> getInputSources() async {
    final settings = GSettings(schemaInputSources);
    final List<String>? inputTypes = [];

    final DBusArray dbusArray = await settings.get(_sourcesKey) as DBusArray;

    for (final DBusValue dbusArrayChild in dbusArray.children) {
      final DBusStruct dbusStruct = dbusArrayChild as DBusStruct;
      inputTypes?.add((dbusStruct.children[1] as DBusString).value);
    }

    await settings.close();

    return inputTypes ?? [];
  }

  Future<void> setInputSources(List<String>? inputTypes) async {
    final settings = GSettings(schemaInputSources);

    final DBusArray array = DBusArray(DBusSignature('(ss)'), [
      for (var inputType in inputTypes ?? [])
        DBusStruct([const DBusString('xkb'), DBusString(inputType)])
    ]);

    await settings.set(_sourcesKey, array);
    await settings.set(_mruSourcesKey, array);

    await settings.close();

    notifyListeners();
  }

  Future<void> removeInputSource(String inputType) async {
    final types = await getInputSources();
    if (types!.length > 1) {
      types.remove(inputType);
      await setInputSources(types);
    }
  }

  Future<void> showKeyboardLayout(String inputType) async {
    await Process.run('gkbd-keyboard-display',
        ['-l', inputType.split('+').first, inputType.split('+').last, '&']);
  }
}
