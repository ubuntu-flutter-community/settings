import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:settings/view/pages/keyboard/input_source_section.dart';
import 'package:settings/view/pages/keyboard/input_source_selection_section.dart';
import 'package:settings/view/pages/keyboard/special_characters_section.dart';

class KeyboardSettingsPage extends StatelessWidget {
  const KeyboardSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);

    return Column(
      children: [
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(service),
          child: const InputSourceSelectionSection(),
        ),
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(service),
          child: const InputSourceSection(),
        ),
        ChangeNotifierProvider(
          create: (_) => InputSourceModel(service),
          child: const SpecialCharactersSection(),
        ),
      ],
    );
  }
}
