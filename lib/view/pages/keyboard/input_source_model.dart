import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class InputSourceModel extends SafeChangeNotifier {
  final Settings? _inputSourceSettings;
  static const _perWindowKey = 'per-window';
  static const _sourcesKey = 'sources';
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

  Future<List<String>?> get sources async {
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

  // List<String> get sources {
  //   final List<String>? inputTypes = [];

  //   final DBusValue dbusValue = _inputSourceSettings?.getValue('sources');

  //   final dynamic dartValue = dbusValue.toNative();
  //   final Iterable<dynamic> dartArray = dartValue as Iterable<dynamic>;
  //   for (final dynamic dartArrayChild in dartArray) {
  //     final Iterable<dynamic> dartStruct = dartArrayChild as Iterable<dynamic>;
  //     for (final dynamic dartStructChild in dartStruct) {
  //       inputTypes?.add(dartStructChild);
  //     }
  //   }

  //   return inputTypes ?? [];
  // }

  List<String>? get xkbOptions =>
      _inputSourceSettings?.getValue(_xkbOptionsKey);

  set xkbOptions(List<String>? value) {
    _inputSourceSettings?.setValue(_xkbOptionsKey, value);
    notifyListeners();
  }
}
