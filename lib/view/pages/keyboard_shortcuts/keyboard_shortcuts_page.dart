import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcuts_model.dart';
import 'package:settings/view/pages/keyboard_shortcuts/navigation_shortcuts_section.dart';
import 'package:settings/view/pages/keyboard_shortcuts/system_shortcuts_section.dart';

class KeyboardShortcutsPage extends StatelessWidget {
  const KeyboardShortcutsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return const KeyboardShortcutsPage();
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return Column(
      children: [
        ChangeNotifierProvider(
          create: (_) =>
              KeyboardShortcutsModel(service, schemaId: schemaWmKeybindings),
          child: const NavigationShortcutsSection(),
        ),
        ChangeNotifierProvider(
          create: (_) => KeyboardShortcutsModel(service,
              schemaId: schemaGnomeShellKeybinding),
          child: const SystemShortcutsSection(),
        ),
      ],
    );
  }
}
