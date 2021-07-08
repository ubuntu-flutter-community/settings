import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/keyboard_shortcuts_page/keyboard_shortcut_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class NavigationShortcutsSection extends StatelessWidget {
  const NavigationShortcutsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.desktop.wm.keybindings';
    return const SettingsSection(
        schemaId: _schemaId,
        headline: 'Navigation Shortcuts',
        children: [
          KeyboardShortcutRow(
              schemaId: _schemaId, settingsKey: 'switch-windows')
        ]);
  }
}
