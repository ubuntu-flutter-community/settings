import 'package:flutter/material.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/keyboard/keyboard_settings_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class KeyboardPage extends StatefulWidget {
  const KeyboardPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return const KeyboardPage();
  }

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
    return const YaruTabbedPage(
      tabIcons: [YaruIcons.input_keyboard, YaruIcons.keyboard_shortcuts],
      tabTitles: ['Keyboard Settings', 'Keyboard Shortcuts'],
      views: [KeyboardSettingsPage(), KeyboardShortcutsPage()],
      width: kDefaultWidth,
    );
  }
}
