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
  static const _xkbOptionsKey = 'xkb-options';

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

  setInputSources(List<String>? inputTypes) async {
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

  Future<List<String>> _getXkbOptions() async {
    final settings = GSettings(schemaInputSources);
    final List<String>? xkbOptions = [];

    final DBusArray dbusArray = await settings.get(_xkbOptionsKey) as DBusArray;

    for (final DBusValue dbusArrayChild in dbusArray.children) {
      final DBusString dBusString = dbusArrayChild as DBusString;
      xkbOptions!.add(dBusString.value);
    }

    return xkbOptions ?? <String>[];
  }

  setXkbOptions(List<String>? value) {
    _inputSourceSettings?.setValue(_xkbOptionsKey, value);
    notifyListeners();
  }

  static const xkbOptionList = [
    'compose:lalt', // Left Alt
    'compose:ralt', // Right Alt
    'compose:lwin', // Left Win
    'compose:rwin', // Right Win
    'compose:menu', // Menu
    'compose:rctrl', // Right Ctrl
    'compose:caps', // Caps Lock
    'compose:prsc', // Print
    'compose:sclk', // Scroll Lock
    'lv3:ralt_alt', // Right Alt key never chooses 3rd level <--- allowed as 'none'
    'lv3:lwin_switch', // Left Win, ignored by GCC
    'lv3:rwin_switch', // Right Win, ignored by GCC
    'lv3:menu_switch', // Menu, ignored by GCC
    'lv3:lalt_switch', // Left Alt, ignored by GCC
    'lv3:ralt_switch', // Right Alt <--- allowed as 'right alt'
    'lv3:switch', // Right Ctrl, ignored by GCC
  ];

  Future<String> getComposeKey() async {
    final list = await _getXkbOptions();
    final composeList = list.where((element) => element.contains('compose'));
    return composeList.isEmpty
        ? 'Default Layout'
        : composeList.first.split(':').last;
  }

  Future<String> getLv3Key() async {
    final list = await _getXkbOptions();
    final lv3List = list.where((element) => element.contains('lv3'));
    return lv3List.isEmpty ? 'Default Layout' : lv3List.first.split(':').last;
  }
}
