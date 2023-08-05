import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/yaru_toggle_buttons_row.dart';
import 'package:settings/view/settings_section.dart';

import 'mouse_and_touchpad_model.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MouseAndTouchpadModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('General'),
      children: [
        YaruToggleButtonsRow(
          actionLabel: 'Primary Button',
          labels: const ['Left', 'Right'],
          actionDescription:
              'Sets the order of physical buttons on mice and touchpads',
          selectedValues: model.leftHanded != null
              ? [!model.leftHanded!, model.leftHanded!]
              : null,
          onPressed: (index) => model.setLeftHanded(index == 1),
        ),
      ],
    );
  }
}
