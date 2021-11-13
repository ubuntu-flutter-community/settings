import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/app_theme.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DarkModeSection extends StatelessWidget {
  const DarkModeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return YaruSection(
      headline: 'Dark mode',
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
      ],
    );
  }
}
