import 'package:flutter/material.dart';
import 'package:linux_system_info/linux_system_info.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/app_theme.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ThemeSection extends StatefulWidget {
  const ThemeSection({Key? key}) : super(key: key);

  @override
  State<ThemeSection> createState() => _ThemeSectionState();
}

class _ThemeSectionState extends State<ThemeSection> {
  late String _osVersion;
  @override
  void initState() {
    _osVersion = SystemInfo().os_version;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    final lightTheme = context.watch<LightTheme>();
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
        if (int.parse(_osVersion.substring(0, 2)) >= 22)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var globalTheme in globalThemeList)
                YaruColorDisk(
                    onPressed: () {
                      lightTheme.value = globalTheme.lightTheme;
                      darkTheme.value = globalTheme.darkTheme;
                      lightGtkTheme.value = globalTheme.lightGtkTheme;
                      darkGtkTheme.value = globalTheme.darkGtkTheme;
                      theme.apply(Theme.of(context).brightness,
                          lightGtkTheme.value, darkGtkTheme.value);
                    },
                    color: globalTheme.primaryColor,
                    selected: Theme.of(context).primaryColor ==
                        globalTheme.primaryColor),
            ],
          )
      ],
    );
  }
}
