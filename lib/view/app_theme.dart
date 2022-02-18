import 'package:flutter/material.dart';
import 'package:settings/services/settings_service.dart';

class AppTheme extends ValueNotifier<ThemeMode> {
  AppTheme(this._settings) : super(ThemeMode.system);

  final Settings _settings;

  void apply(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        value = ThemeMode.dark;
        _settings.setValue('gtk-theme', 'Yaru-dark');
        break;
      case Brightness.light:
        value = ThemeMode.light;
        _settings.setValue('gtk-theme', 'Yaru');
        break;
    }
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }
}

class LightTheme extends ValueNotifier<ThemeData> {
  LightTheme(ThemeData value) : super(value);
}

class DarkTheme extends ValueNotifier<ThemeData> {
  DarkTheme(ThemeData value) : super(value);
}
