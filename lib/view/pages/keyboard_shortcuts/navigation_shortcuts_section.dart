import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcut_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class NavigationShortcutsSection extends StatelessWidget {
  const NavigationShortcutsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsSection(
      headline: 'Navigation Shortcuts',
      children: [
        KeyboardShortcutRow(
          label: 'Switch windows',
          shortcutId: 'switch-windows',
        ),
        KeyboardShortcutRow(
          label: 'Switch windows backward',
          shortcutId: 'switch-windows-backward',
        ),
      ],
    );
  }
}
