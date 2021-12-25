import 'package:dbus/dbus.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/input_type.dart';

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

  List<InputType>? get sources {
    final inputTypes = <InputType>[];

    final DBusArray dbusArray =
        _inputSourceSettings?.getValue(_sourcesKey) as DBusArray;

    for (final DBusValue dbusArrayChild in dbusArray.children) {
      final DBusStruct dbusStruct = dbusArrayChild as DBusStruct;
      for (final DBusValue dbusStructChild in dbusStruct.children) {
        inputTypes.add(InputType(
            runTimeType: dbusStructChild.runtimeType.toString(),
            countryCode: dbusStructChild.toString()));
      }
    }

    return inputTypes;
  }

  set sources(List<InputType>? inputTypes) {
    final DBusStruct dbusStructFromValue = DBusStruct(
        inputTypes?.map((inputType) => DBusString(inputType.toString()))
            as Iterable<DBusString>);

    final DBusArray array =
        DBusArray(DBusSignature('(ss)'), [dbusStructFromValue]);

    _inputSourceSettings?.setValue(_sourcesKey, array);
    notifyListeners();
  }

  List<String>? get xkbOptions =>
      _inputSourceSettings?.getValue(_xkbOptionsKey);

  set xkbOptions(List<String>? value) {
    _inputSourceSettings?.setValue(_xkbOptionsKey, value);
    notifyListeners();
  }
}
