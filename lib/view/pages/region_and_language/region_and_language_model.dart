import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/locale_service.dart';

class RegionAndLanguageModel extends SafeChangeNotifier {

  RegionAndLanguageModel({required LocaleService localeService})
      : _localeService = localeService;
  final LocaleService _localeService;
  List<String?>? get locales => _localeService.locales;
  List<String> installedLocales = [];

  StreamSubscription? _localeSub;

  Future<void> init() {
    _initInstalledLocales();
    return _localeService.init().then((_) async {
      _localeSub =
          _localeService.localeChanged.listen((_) => notifyListeners());
      notifyListeners();
    });
  }

  String get locale =>
      _localeService.locale != null && _localeService.locale!.first != null
          ? _localeService.locale!.first!
          : '';
  set locale(String locale) =>
      _localeService.locale = ['LANG=$locale'.replaceAll('utf8', 'UTF-8')];

  String get prettyLocale =>
      locale.replaceAll('.UTF-8', '').replaceAll('LANG=', '');

  @override
  void dispose() async {
    await _localeSub?.cancel();
    super.dispose();
  }

  void openGnomeLanguageSelector() {
    Process.run('gnome-language-selector', []);
  }

  void _initInstalledLocales() async {
    await Process.run('locale', ['-a']).then((value) {
      installedLocales = const LineSplitter().convert(value.stdout);
      installedLocales.retainWhere((element) => element.endsWith('.utf8'));
      installedLocales =
          installedLocales.map((e) => e.replaceAll('.utf8', '')).toList();
    });
  }
}
