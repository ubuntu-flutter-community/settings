import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class SpecialCharactersModel extends SafeChangeNotifier {
  final Settings? _inputSourceSettings;
  static const _xkbOptionsKey = 'xkb-options';

  SpecialCharactersModel(SettingsService service)
      : _inputSourceSettings = service.lookup(schemaInputSources) {
    _inputSourceSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _inputSourceSettings?.removeListener(notifyListeners);
    super.dispose();
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

  _setXkbOptions(List<String> xkbOptions) async {
    _inputSourceSettings?.setValue(_xkbOptionsKey, xkbOptions);

    notifyListeners();
  }

  void setComposeOptions(ComposeOptions composeOptions) async {
    switch (composeOptions) {
      case ComposeOptions.leftAlt:
        await _setXkbOptions(['compose:lalt']);
        break;
      case ComposeOptions.rightAlt:
        await _setXkbOptions(['compose:ralt']);
        break;
      case ComposeOptions.leftWin:
        await _setXkbOptions(['compose:lwin']);
        break;
      case ComposeOptions.rightWin:
        await _setXkbOptions(['compose:rwin']);
        break;
      case ComposeOptions.menu:
        await _setXkbOptions(['compose:menu']);
        break;
      case ComposeOptions.rightCtrl:
        await _setXkbOptions(['compose:rctrl']);
        break;
      case ComposeOptions.caps:
        await _setXkbOptions(['compose:caps']);
        break;
      case ComposeOptions.print:
        await _setXkbOptions(['compose:prsc']);
        break;
      case ComposeOptions.scrollLock:
        await _setXkbOptions(['compose:sclk']);
        break;
      case ComposeOptions.defaultLayout:
        await _setXkbOptions([]);
        break;
      default:
        ComposeOptions.defaultLayout;
    }
  }

  Future<ComposeOptions> getComposeOptions() async {
    final options = (await _getXkbOptions())
        .where((xkbOption) => xkbOption.contains('compose'));

    if (options.isNotEmpty) {
      final composeOptionString = options.first;

      if (composeOptionString.contains('compose:ralt')) {
        return ComposeOptions.rightAlt;
      }
      if (composeOptionString.contains('compose:lwin')) {
        return ComposeOptions.leftWin;
      }
      if (composeOptionString.contains('compose:rwin')) {
        return ComposeOptions.rightWin;
      }
      if (composeOptionString.contains('compose:menu')) {
        return ComposeOptions.menu;
      }
      if (composeOptionString.contains('compose:rctrl')) {
        return ComposeOptions.rightCtrl;
      }
      if (composeOptionString.contains('compose:caps')) {
        return ComposeOptions.caps;
      }
      if (composeOptionString.contains('compose:prsc')) {
        return ComposeOptions.print;
      }
      if (composeOptionString.contains('compose:sclk')) {
        return ComposeOptions.scrollLock;
      }
      if (composeOptionString.contains('compose:lalt')) {
        return ComposeOptions.leftAlt;
      }
    }
    return ComposeOptions.defaultLayout;
  }
}

enum ComposeOptions {
  leftAlt,
  rightAlt,
  leftWin,
  rightWin,
  menu,
  rightCtrl,
  caps,
  print,
  scrollLock,
  defaultLayout
}
