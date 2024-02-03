import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class SpecialCharactersModel extends SafeChangeNotifier {
  SpecialCharactersModel(SettingsService service)
      : _inputSourceSettings = service.lookup(schemaInputSources) {
    _inputSourceSettings?.addListener(notifyListeners);
  }
  final Settings? _inputSourceSettings;
  static const _xkbOptionsKey = 'xkb-options';

  @override
  void dispose() {
    _inputSourceSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  Future<List<String>> _getXkbOptions() async {
    final settings = GSettings(schemaInputSources);
    final xkbOptions = <String>[];

    final dbusArray = await settings.get(_xkbOptionsKey) as DBusArray;

    for (final dbusArrayChild in dbusArray.children) {
      final dBusString = dbusArrayChild as DBusString;
      xkbOptions.add(dBusString.value);
    }

    return xkbOptions;
  }

  Future<void> _setXkbOptions(List<String> xkbOptions) async {
    await _inputSourceSettings?.setValue(_xkbOptionsKey, xkbOptions);

    notifyListeners();
  }

  void setComposeOptions(ComposeOptions composeOptions) async {
    final currentOptions = await _getXkbOptions();
    currentOptions.removeWhere((element) => element.contains('compose:'));
    switch (composeOptions) {
      case ComposeOptions.leftAlt:
        currentOptions.add('compose:lalt');
        break;
      case ComposeOptions.rightAlt:
        currentOptions.add('compose:ralt');
        break;
      case ComposeOptions.leftWin:
        currentOptions.add('compose:lwin');
        break;
      case ComposeOptions.rightWin:
        currentOptions.add('compose:rwin');
        break;
      case ComposeOptions.menu:
        currentOptions.add('compose:menu');
        break;
      case ComposeOptions.rightCtrl:
        currentOptions.add('compose:rctrl');
        break;
      case ComposeOptions.caps:
        currentOptions.add('compose:caps');
        break;
      case ComposeOptions.print:
        currentOptions.add('compose:prsc');
        break;
      case ComposeOptions.scrollLock:
        currentOptions.add('compose:sclk');
        break;
      case ComposeOptions.defaultLayout:
        break;
    }
    await _setXkbOptions(currentOptions);
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

  final composeOptionsToStringMap = <ComposeOptions, String>{
    ComposeOptions.rightAlt: 'Right Alt-Key',
    ComposeOptions.leftAlt: 'Left Alt-Key',
    ComposeOptions.leftWin: 'Left Super-Key',
    ComposeOptions.rightWin: 'Right Super-Key',
    ComposeOptions.menu: 'Menu-Key',
    ComposeOptions.rightCtrl: 'Right Control-Key',
    ComposeOptions.caps: 'Caps-Lock-Key',
    ComposeOptions.print: 'Print-Key',
    ComposeOptions.scrollLock: 'Scroll-Lock-Key',
    ComposeOptions.defaultLayout: 'Default Layout',
  };

  Future<Lv3Options?> getLv3Options() async {
    final options =
        (await _getXkbOptions()).where((element) => element.contains('lv3'));

    for (final option in options) {
      if (option.contains('lv3:ralt_alt') && options.length < 2) {
        return Lv3Options.none;
      }
    }
    for (final option in options) {
      if (option.contains('lv3:ralt_switch')) {
        return Lv3Options.rightAlt;
      }
    }

    return null;
  }

  final lv3OptionsToStringMap = <Lv3Options?, String>{
    null: 'Default Layout',
    Lv3Options.none: 'None',
    Lv3Options.rightAlt: 'Right Alt-Key',
  };

  void setLv3Options(Lv3Options lv3options) async {
    final currentOptions = await _getXkbOptions();
    currentOptions.removeWhere((element) => element.contains('lv3:'));
    switch (lv3options) {
      case Lv3Options.none:
        currentOptions.add('lv3:ralt_alt');
        break;
      case Lv3Options.rightAlt:
        currentOptions.addAll(['lv3:ralt_alt', 'lv3:ralt_switch']);
        break;
      default:
    }
    await _setXkbOptions(currentOptions);
  }

  void removeLV3Options(bool value) async {
    final currentOptions = await _getXkbOptions();
    currentOptions.removeWhere((element) => element.contains('lv3:'));
    if (!value) {
      currentOptions.add('lv3:ralt_alt');
    }
    await _setXkbOptions(currentOptions);
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
  defaultLayout;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case ComposeOptions.leftAlt:
        return 'leftAlt';
      case ComposeOptions.rightAlt:
        return 'rightAlt';
      case ComposeOptions.leftWin:
        return 'leftWin';
      case ComposeOptions.menu:
        return 'menu';
      case ComposeOptions.rightCtrl:
        return 'rightCtrl';
      case ComposeOptions.caps:
        return 'caps';
      case ComposeOptions.print:
        return 'print';
      case ComposeOptions.scrollLock:
        return 'scrollLock';
      case ComposeOptions.defaultLayout:
        return 'defaultLayout';
      case ComposeOptions.rightWin:
        return 'rightWin';
      default:
        return '';
    }
  }
}

// 'lv3:ralt_alt', // Right Alt key never chooses 3rd level <--- allowed as 'none'
// 'lv3:lwin_switch', // Left Win, ignored by GCC
// 'lv3:rwin_switch', // Right Win, ignored by GCC
// 'lv3:menu_switch', // Menu, ignored by GCC
// 'lv3:lalt_switch', // Left Alt, ignored by GCC
// 'lv3:ralt_switch', // Right Alt <--- allowed as 'right alt'
// 'lv3:switch', // Right Ctrl, ignored by GCC

enum Lv3Options { none, leftWin, rightWin, menu, leftAlt, rightAlt, rightCtrl }
