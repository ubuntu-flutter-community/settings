import 'package:flutter/material.dart';
import 'package:linux_system_info/linux_system_info.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/app_theme.dart';
import 'package:yaru/yaru.dart';
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
    final theme = YaruTheme.of(context);
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
            value: YaruTheme.of(context).themeMode == ThemeMode.dark,
            onChanged: (_) => AppTheme.apply(context,
                themeMode: theme.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light)),
        if (int.parse(_osVersion.substring(0, 2)) >= 22)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final variant in YaruVariant.values.take(10)) // skip flavors
                YaruColorDisk(
                  color: variant.color,
                  selected:
                      variant == theme.variant && theme.highContrast != true,
                  onPressed: () => AppTheme.apply(context,
                      variant: variant, highContrast: false),
                ),
            ],
          )
      ],
    );
  }
}
