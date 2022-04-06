import 'package:flutter/material.dart';
import 'package:settings/services/settings_service.dart';
import 'package:yaru/yaru.dart';

class AppTheme extends ValueNotifier<ThemeMode> {
  AppTheme(this._settings) : super(ThemeMode.system);

  final Settings _settings;

  void apply(Brightness brightness, String lightGtkTheme, String darkGtkTheme) {
    switch (brightness) {
      case Brightness.dark:
        value = ThemeMode.dark;
        _settings.setValue('gtk-theme', darkGtkTheme);
        _settings.setValue('color-scheme', 'prefer-dark');
        break;
      case Brightness.light:
        value = ThemeMode.light;
        _settings.setValue('gtk-theme', lightGtkTheme);
        _settings.setValue('color-scheme', 'default');
        break;
    }
  }

  void setGnomeTheme(String gnomeThemeName) {
    _settings.setValue('gtk-theme', gnomeThemeName);
    _settings.setValue('icon-theme', gnomeThemeName);
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

class LightGtkTheme extends ValueNotifier<String> {
  LightGtkTheme(String value) : super(value);
}

class DarkGtkTheme extends ValueNotifier<String> {
  DarkGtkTheme(String value) : super(value);
}

final List<GlobalTheme> globalThemeList = [
  GlobalTheme(
    lightTheme: yaruLight,
    darkTheme: yaruDark,
    lightGtkTheme: 'Yaru',
    darkGtkTheme: 'Yaru-dark',
    primaryColor: YaruColors.ubuntuOrange,
  ),
  GlobalTheme(
    lightTheme: yaruSageLight,
    darkTheme: yaruSageDark,
    lightGtkTheme: 'Yaru-sage',
    darkGtkTheme: 'Yaru-sage-dark',
    primaryColor: sageMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruBarkLight,
    darkTheme: yaruBarkDark,
    lightGtkTheme: 'Yaru-bark',
    darkGtkTheme: 'Yaru-bark-dark',
    primaryColor: barkMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruOliveLight,
    darkTheme: yaruOliveDark,
    lightGtkTheme: 'Yaru-olive',
    darkGtkTheme: 'Yaru-olive-dark',
    primaryColor: oliveMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruViridianLight,
    darkTheme: yaruViridianDark,
    lightGtkTheme: 'Yaru-viridian',
    darkGtkTheme: 'Yaru-viridian-dark',
    primaryColor: viridianMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruPrussianGreenLight,
    darkTheme: yaruPrussianGreenDark,
    lightGtkTheme: 'Yaru-prussiangreen',
    darkGtkTheme: 'Yaru-prussiangreen-dark',
    primaryColor: prussianGreenMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruBlueLight,
    darkTheme: yaruBlueDark,
    lightGtkTheme: 'Yaru-blue',
    darkGtkTheme: 'Yaru-blue-dark',
    primaryColor: blueMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruPurpleLight,
    darkTheme: yaruPurpleDark,
    lightGtkTheme: 'Yaru-purple',
    darkGtkTheme: 'Yaru-purple-dark',
    primaryColor: purpleMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yarMagentaLight,
    darkTheme: yaruMagentaDark,
    lightGtkTheme: 'Yaru-magenta',
    darkGtkTheme: 'Yaru-magenta-dark',
    primaryColor: magentaMaterialColor,
  ),
  GlobalTheme(
    lightTheme: yaruRedLight,
    darkTheme: yaruRedDark,
    lightGtkTheme: 'Yaru-red',
    darkGtkTheme: 'Yaru-red-dark',
    primaryColor: lightRedMaterialColor,
  ),
];

class GlobalTheme {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String lightGtkTheme;
  final String darkGtkTheme;
  final MaterialColor primaryColor;

  GlobalTheme({
    required this.lightTheme,
    required this.darkTheme,
    required this.lightGtkTheme,
    required this.darkGtkTheme,
    required this.primaryColor,
  });
}
