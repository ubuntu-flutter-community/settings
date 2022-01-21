import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'mouse_and_touchpad_model.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MouseAndTouchpadModel>();

    return YaruSection(
      width: kDefaultWidth,
      headline: 'General',
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
