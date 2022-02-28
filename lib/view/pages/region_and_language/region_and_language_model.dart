import 'dart:async';
import 'dart:io';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/services/locale_service.dart';

class RegionAndLanguageModel extends SafeChangeNotifier {
  final LocaleService _localeService;

  RegionAndLanguageModel({required LocaleService localeService})
      : _localeService = localeService;

  StreamSubscription? _localeSub;

  Future<void> init() => _localeService.init().then((_) async {
        _localeSub =
            _localeService.localeChanged.listen((_) => notifyListeners());
        notifyListeners();
      });

  List<String?>? get locale => _localeService.locale;
  set locale(List<String?>? locale) => _localeService.locale = locale;

  @override
  void dispose() async {
    await _localeSub?.cancel();
    super.dispose();
  }

  Future<void> openGnomeLanguageSelector() async {
    await Process.run('gnome-language-selector', []);
  }
}
