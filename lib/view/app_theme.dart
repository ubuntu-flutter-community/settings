import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart';

class AppTheme {
  static YaruThemeData of(BuildContext context) {
    return SharedAppData.getValue(
        context, 'theme', () => const YaruThemeData());
  }

  static void apply(
    BuildContext context, {
    YaruVariant? variant,
    bool? highContrast,
    ThemeMode? themeMode,
  }) {
    SharedAppData.setValue(
      context,
      'theme',
      AppTheme.of(context).copyWith(
        themeMode: themeMode,
        variant: variant,
        highContrast: highContrast,
      ),
    );
    final value = themeMode == ThemeMode.dark ? 'prefer-dark' : 'prefer-light';
    final settings = context.read<GSettings>();
    settings.set('color-scheme', DBusString(value));
  }
}
