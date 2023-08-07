import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/title_bar_tab.dart';
import 'package:settings/view/pages/keyboard/keyboard_settings_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

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
    const views = [KeyboardSettingsPage(), KeyboardShortcutsPage()];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: YaruWindowTitleBar(
          border: BorderSide.none,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const SizedBox(
            width: 400,
            child: TabBar(tabs: [
              TitleBarTab(
                  text: 'Keyboard Settings', iconData: YaruIcons.keyboard,),
              TitleBarTab(
                text: 'Keyboard Shortcuts',
                iconData: YaruIcons.keyboard_shortcuts,
              ),
            ],),
          ),
        ),
        body: TabBarView(
          children: views
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: kYaruPagePadding),
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
