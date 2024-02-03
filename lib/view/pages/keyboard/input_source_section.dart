import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class InputSourceSection extends StatelessWidget {
  const InputSourceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final inputSourceModel = context.watch<InputSourceModel>();

    return Column(
      children: [
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Change input sources'),
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('Use the same input for all windows'),
              leading: YaruRadio(
                value: false,
                groupValue: inputSourceModel.perWindow,
                onChanged: (_) => inputSourceModel.perWindow = false,
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('Give each window its own input source'),
              leading: YaruRadio(
                value: true,
                groupValue: inputSourceModel.perWindow,
                onChanged: (_) => inputSourceModel.perWindow = true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
