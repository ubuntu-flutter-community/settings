import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:settings/view/pages/keyboard/input_source_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

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
        const YaruSection(headline: 'Special characters', children: []),
      ],
    );
  }
}

class InputSourceSelectionSection extends StatelessWidget {
  const InputSourceSelectionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputSourceModel = context.watch<InputSourceModel>();
    final sources = inputSourceModel.sources ?? [];
    return YaruSection(headline: 'Input Sources', children: [
      for (var item in sources)
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.toString()),
            ),
          ],
        )
    ]);
  }
}
