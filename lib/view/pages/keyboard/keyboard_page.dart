import 'package:flutter/material.dart';
import 'package:settings/view/pages/keyboard/keyboard_settings_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_page.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

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
    return Column(
      children: [
        Container(
          width: 516,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
              tabs: const [
                Tab(
                    icon: Icon(YaruIcons.input_keyboard),
                    child: Text("Keyboard Settings")),
                Tab(
                    icon: Icon(YaruIcons.font),
                    child: Text("Keyboard Shortcuts")),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 1000,
            child: TabBarView(
              controller: tabController,
              children: const [KeyboardSettingsPage(), KeyboardShortcutsPage()],
            ),
          ),
        ),
      ],
    );
  }
}
