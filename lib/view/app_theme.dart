import 'package:flutter/material.dart';
import 'package:settings/services/settings_service.dart';
import 'package:yaru/yaru.dart';

class AppTheme extends ValueNotifier<ThemeMode> {
  AppTheme(this._settings) : super(ThemeMode.system);

  final Settings _settings;

  void apply(Brightness brightness, YaruVariant variant) {
    switch (brightness) {
      case Brightness.dark:
        value = ThemeMode.dark;
        _settings.setValue('gtk-theme', variant.gtkThemeNameDark);
        _settings.setValue('color-scheme', 'prefer-dark');
        _settings.setValue('icon-theme', variant.gtkThemeNameDark);
        break;
      case Brightness.light:
        value = ThemeMode.light;
        _settings.setValue('gtk-theme', variant.gtkThemeName);
        _settings.setValue('color-scheme', 'default');
        _settings.setValue('icon-theme', variant.gtkThemeName);
        break;
    }
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }
}

const List<YaruVariant> globalThemeList = [
  YaruVariant.orange,
  YaruVariant.bark,
  YaruVariant.sage,
  YaruVariant.olive,
  YaruVariant.viridian,
  YaruVariant.prussianGreen,
  YaruVariant.blue,
  YaruVariant.purple,
  YaruVariant.magenta,
  YaruVariant.red,
];

extension YaruVariantName on YaruVariant {
  String get gtkThemeName {
    return this == YaruVariant.orange ? 'Yaru' : 'Yaru-${name.toLowerCase()}';
  }

  String get gtkThemeNameDark {
    return '$gtkThemeName-dark';
  }
}
