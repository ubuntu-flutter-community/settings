import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:settings/view/pages/keyboard/input_source_section.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_page.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
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
    final service = Provider.of<SettingsService>(context);
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
              children: [
                createKeyBoardSettingsView(service, context),
                const KeyboardShortcutsPage()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column createKeyBoardSettingsView(
      SettingsService service, BuildContext context) {
    return Column(
      children: [
        const YaruSection(headline: 'Input Sources', children: []),
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(service),
          child: const InputSourceSection(),
        ),
        const YaruSection(headline: 'Special characters', children: []),
        // YaruSection(headline: 'Keyboard Shortcuts', children: [
        //   InkWell(
        //     borderRadius: BorderRadius.circular(4),
        //     onTap: () => showDialog(
        //       context: context,
        //       builder: (context) => const AlertDialog(
        //         title: Text('Change Keyboard shortcuts'),
        //         content: KeyboardShortcutsPage(),
        //         actions: [],
        //       ),
        //     ),
        //     child: const YaruRow(
        //         trailingWidget: Text('Change keyboard shortcuts'),
        //         actionWidget: Icon(YaruIcons.pan_end)),
        //   )
        // ]),
      ],
    );
  }
}
