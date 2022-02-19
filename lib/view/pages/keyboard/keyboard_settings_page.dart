import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/input_source_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:settings/view/pages/keyboard/input_source_section.dart';
import 'package:settings/view/pages/keyboard/input_source_selection_section.dart';
import 'package:settings/view/pages/keyboard/special_characters_model.dart';
import 'package:settings/view/pages/keyboard/special_characters_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class KeyboardSettingsPage extends StatelessWidget {
  const KeyboardSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsService =
        Provider.of<SettingsService>(context, listen: false);
    final inputSourceService =
        Provider.of<InputSourceService>(context, listen: false);

    return YaruPage(
      children: [
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(settingsService, inputSourceService),
          child: const InputSourceSelectionSection(),
        ),
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(settingsService, inputSourceService),
          child: const InputSourceSection(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpecialCharactersModel(settingsService),
          child: const SpecialCharactersSection(),
        ),
      ],
    );
  }
}
