import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class DarkModeSection extends StatelessWidget {
  const DarkModeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return SettingsSection(
      headline: 'Dark mode',
      children: [
        SwitchSettingsRow(
            actionLabel: Theme.of(context).brightness == Brightness.light
                ? 'Turn on dark mode'
                : 'Turn off dark mode',
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
