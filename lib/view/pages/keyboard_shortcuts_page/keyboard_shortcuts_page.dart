import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/keyboard_shortcuts_page/navigation_shortcuts_section.dart';

class KeyboardShortcutsPage extends StatelessWidget {
  const KeyboardShortcutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        NavigationShortcutsSection(),
      ],
    );
  }
}
