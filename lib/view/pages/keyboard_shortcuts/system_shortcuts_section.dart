import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcut_row.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SystemShortcutsSection extends StatelessWidget {
  const SystemShortcutsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YaruSection(
      headline: 'System',
      children: [
        KeyboardShortcutRow(
          label: 'Toggle Apps Grid',
          shortcutId: 'toggle-application-view',
        ),
      ],
    );
  }
}
