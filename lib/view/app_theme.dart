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
        break;
      case Brightness.light:
        value = ThemeMode.light;
        _settings.setValue('gtk-theme', lightGtkTheme);
        break;
    }
  }

  void setGtkTheme(String gtkTheme) =>
      _settings.setValue('gtk-theme', gtkTheme);

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
  // GlobalTheme(
  //     lightTheme: yaruSageLight,
  //     darkTheme: yaruSageDark,
  //     lightGtkTheme: 'Yaru-sage',
  //     darkGtkTheme: 'Yaru-sage-dark'),
  // GlobalTheme(
  //     lightTheme: yaruBarkLight,
  //     darkTheme: yaruBarkDark,
  //     lightGtkTheme: 'Yaru-bark',
  //     darkGtkTheme: 'Yaru-bark-dark'),
  // GlobalTheme(
  //     lightTheme: yaruOliveLight,
  //     darkTheme: yaruOliveDark,
  //     lightGtkTheme: 'Yaru-olive',
  //     darkGtkTheme: 'Yaru-olive-dark'),
  // GlobalTheme(
  //     lightTheme: yaruViridianLight,
  //     darkTheme: yaruViridianDark,
  //     lightGtkTheme: 'Yaru-viridian',
  //     darkGtkTheme: 'Yaru-viridian-dark'),
  // GlobalTheme(
  //     lightTheme: yaruPrussianGreenLight,
  //     darkTheme: yaruPrussianGreenDark,
  //     lightGtkTheme: 'Yaru-prussiangreen',
  //     darkGtkTheme: 'Yaru-prussiangreen-dark'),
  // GlobalTheme(
  //     lightTheme: yaruBlueLight,
  //     darkTheme: yaruBlueDark,
  //     lightGtkTheme: 'Yaru-blue',
  //     darkGtkTheme: 'Yaru-blue-dark'),
  // GlobalTheme(
  //     lightTheme: yaruPurpleLight,
  //     darkTheme: yaruPurpleDark,
  //     lightGtkTheme: 'Yaru-purple',
  //     darkGtkTheme: 'Yaru-purple-dark'),
  // GlobalTheme(
  //     lightTheme: yarMagentaLight,
  //     darkTheme: yaruMagentaDark,
  //     lightGtkTheme: 'Yaru-magenta',
  //     darkGtkTheme: 'Yaru-magenta-dark'),
  // GlobalTheme(
  //     lightTheme: yaruRedLight,
  //     darkTheme: yaruRedDark,
  //     lightGtkTheme: 'Yaru-red',
  //     darkGtkTheme: 'Yaru-red-dark'),
  GlobalTheme(
    lightTheme: yaruKubuntuLight,
    darkTheme: yaruKubuntuDark,
    lightGtkTheme: 'Adwaita',
    darkGtkTheme: 'Adwaita-dark',
    primaryColor: FlavorColors.kubuntuBlue,
  )
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
