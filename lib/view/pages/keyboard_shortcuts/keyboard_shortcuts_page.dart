import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcuts_model.dart';
import 'package:settings/view/pages/keyboard_shortcuts/navigation_shortcuts_section.dart';

class KeyboardShortcutsPage extends StatelessWidget {
  const KeyboardShortcutsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KeyboardShortcutsModel(),
      child: const KeyboardShortcutsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        NavigationShortcutsSection(),
      ],
    );
  }
}
