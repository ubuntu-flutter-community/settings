import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/app_theme.dart';
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
              theme.apply(Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark);
            }),
        YaruRow(
            trailingWidget: const Text('Change theme'),
            actionWidget: Row(
              children: [
                YaruColorPickerButton(
                    color: yaruLight.primaryColor,
                    onPressed: () {
                      lighTheme.value = yaruLight;
                      darkTheme.value = yaruDark;
                    }),
                const SizedBox(
                  width: 10,
                ),
                YaruColorPickerButton(
                    color: yaruKubuntuLight.primaryColor,
                    onPressed: () {
                      lighTheme.value = yaruKubuntuLight;
                      darkTheme.value = yaruKubuntuDark;
                    }),
                const SizedBox(
                  width: 10,
                ),
                YaruColorPickerButton(
                    color: yaruMateLight.primaryColor,
                    onPressed: () {
                      lighTheme.value = yaruMateLight;
                      darkTheme.value = yaruMateDark;
                    }),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            enabled: true)
      ],
    );
  }
}
