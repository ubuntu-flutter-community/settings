import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/keyboard_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcut_row.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class KeyboardShortcutsPage extends StatelessWidget {
  const KeyboardShortcutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      children: [
        ChangeNotifierProvider(
          create: (_) => KeyboardShortcutsModel(
            keyboard: context.read<KeyboardService>(),
            settings: context.read<SettingsService>(),
            schemaId: schemaWmKeybindings,
          ),
          child: SettingsSection(
            width: kDefaultWidth,
            headline: const Text('Navigation Shortcuts'),
            children: const [
              KeyboardShortcutRow(
                label: 'Switch windows',
                shortcutId: 'switch-windows',
              ),
              KeyboardShortcutRow(
                label: 'Switch windows backward',
                shortcutId: 'switch-windows-backward',
              ),
            ],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => KeyboardShortcutsModel(
            keyboard: context.read<KeyboardService>(),
            settings: context.read<SettingsService>(),
            schemaId: schemaGnomeShellKeybinding,
          ),
          child: SettingsSection(
            width: kDefaultWidth,
            headline: const Text('System'),
            children: const [
              KeyboardShortcutRow(
                label: 'Toggle Apps Grid',
                shortcutId: 'toggle-application-view',
              ),
            ],
          ),
        )
      ],
    );
  }
}
