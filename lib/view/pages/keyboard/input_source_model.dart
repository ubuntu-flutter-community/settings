import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/input_source_service.dart';
import 'package:yaru/yaru.dart';

class InputSourceModel extends SafeChangeNotifier {
  InputSourceModel(
    GSettingsService settingsService,
    InputSourceService inputSourceService,
  )   : _inputSourceSettings = settingsService.lookup(schemaInputSources),
        inputSources = inputSourceService.inputSources {
    _inputSourceSettings?.addListener(notifyListeners);
  }
  final GnomeSettings? _inputSourceSettings;
  static const _perWindowKey = 'per-window';
  static const _sourcesKey = 'sources';
  static const _mruSourcesKey = 'mru-sources';
  final List<InputSource> inputSources;

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
    final settings = GnomeSettings(schemaInputSources);
    final inputTypes = <String>[];

    final dbusArray = await settings.getValue(_sourcesKey) as DBusArray;

    for (final dbusArrayChild in dbusArray.children) {
      final dbusStruct = dbusArrayChild as DBusStruct;
      inputTypes.add((dbusStruct.children[1] as DBusString).value);
    }

    await settings.dispose();

    return inputTypes;
  }

  Future<void> setInputSources(List<String>? inputTypes) async {
    final settings = GnomeSettings(schemaInputSources);

    final array = DBusArray(DBusSignature('(ss)'), [
      for (final inputType in inputTypes ?? [])
        DBusStruct([const DBusString('xkb'), DBusString(inputType)]),
    ]);

    await settings.setValue(_sourcesKey, array);
    await settings.setValue(_mruSourcesKey, array);

    await settings.dispose();

    notifyListeners();
  }

  Future<void> removeInputSource(String inputType) async {
    final types = await getInputSources();
    if (types!.length > 1) {
      types.remove(inputType);
      await setInputSources(types);
    }
  }

  Future<void> addInputSource(String inputSource) async {
    final sources = await getInputSources();
    sources?.add(inputSource);
    await setInputSources(sources);
  }

  Future<void> showKeyboardLayout(String inputType) async {
    await Process.run(
      'gkbd-keyboard-display',
      ['-l', inputType.split('+').first, inputType.split('+').last, '&'],
    );
  }
}
