import 'package:flutter/material.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/keyboard/keyboard_settings_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_page.dart';
import 'package:settings/view/tabbed_page.dart';
import 'package:yaru_icons/yaru_icons.dart';

class KeyboardPage extends StatefulWidget {
  const KeyboardPage({super.key});

  static Widget create(BuildContext context) => const KeyboardPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.keyboardPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.keyboardPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  State<KeyboardPage> createState() => _KeyboardPageState();
}

class _KeyboardPageState extends State<KeyboardPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const TabbedPage(
      tabIcons: [
        Icon(YaruIcons.keyboard),
        Icon(YaruIcons.keyboard_shortcuts),
      ],
      tabTitles: ['Keyboard Settings', 'Keyboard Shortcuts'],
      views: [KeyboardSettingsPage(), KeyboardShortcutsPage()],
      width: kDefaultWidth,
    );
  }
}
