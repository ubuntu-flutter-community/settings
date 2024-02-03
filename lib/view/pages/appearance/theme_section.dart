import 'package:flutter/material.dart';
import 'package:linux_system_info/linux_system_info.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ThemeSection extends StatefulWidget {
  const ThemeSection({super.key});

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

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('Theme'),
      children: [
        YaruSwitchRow(
          trailingWidget: Theme.of(context).brightness == Brightness.light
              ? const Row(
                  children: [
                    Icon(YaruIcons.sun),
                    SizedBox(width: 8),
                    Text('Dark mode is turned off'),
                  ],
                )
              : const Row(
                  children: [
                    Icon(YaruIcons.clear_night),
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
              YaruTheme.of(context).variant ?? YaruVariant.orange,
            );
          },
        ),
        if (int.parse(_osVersion.substring(0, 2)) >= 22)
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (final globalTheme in globalThemeList)
                YaruColorDisk(
                  onPressed: () {
                    theme.apply(Theme.of(context).brightness, globalTheme);
                  },
                  color: globalTheme.color,
                  selected: YaruTheme.of(context).variant == globalTheme,
                ),
            ],
          ),
      ],
    );
  }
}
