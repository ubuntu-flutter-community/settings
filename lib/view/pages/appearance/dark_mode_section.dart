import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/pages/appearance/color_disk.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DarkModeSection extends StatelessWidget {
  const DarkModeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    final lighTheme = context.watch<LightTheme>();
    final darkTheme = context.watch<DarkTheme>();
    final lightGtkTheme = context.watch<LightGtkTheme>();
    final darkGtkTheme = context.watch<DarkGtkTheme>();

    return YaruSection(
      width: kDefaultWidth,
      headline: 'Theme',
      children: [
        YaruSwitchRow(
            trailingWidget: Theme.of(context).brightness == Brightness.light
                ? Row(
                    children: const [
                      Icon(YaruIcons.weather_clear),
                      SizedBox(width: 8),
                      Text('Dark mode is turned off'),
                    ],
                  )
                : Row(
                    children: const [
                      Icon(YaruIcons.weather_clear_night),
                      SizedBox(width: 8),
                      Text('Dark mode is turned on'),
                    ],
                  ),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) {
              theme.apply(
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
                  lightGtkTheme.value,
                  darkGtkTheme.value);
            }),
        YaruRow(
            trailingWidget: const Text('Change theme'),
            actionWidget: Row(
              children: [
                for (var globalTheme in globalThemeList)
                  ColorDisk(
                      onPressed: () {
                        lighTheme.value = globalTheme.lightTheme;
                        darkTheme.value = globalTheme.darkTheme;
                        lightGtkTheme.value = globalTheme.lightGtkTheme;
                        darkGtkTheme.value = globalTheme.darkGtkTheme;
                        theme.setGtkTheme(theme.value == ThemeMode.light
                            ? lightGtkTheme.value
                            : darkGtkTheme.value);
                      },
                      color: globalTheme.primaryColor,
                      selected: Theme.of(context).primaryColor ==
                          globalTheme.primaryColor),
              ],
            ),
            enabled: true)
      ],
    );
  }
}
