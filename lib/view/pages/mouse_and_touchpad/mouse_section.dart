import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MouseSection extends StatelessWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MouseAndTouchpadModel>();

    return YaruSection(
      width: kDefaultWidth,
      headline: 'Mouse',
      children: [
        YaruSliderRow(
          actionLabel: 'Speed',
          value: model.mouseSpeed,
          showValue: false,
          min: -1,
          max: 1,
          defaultValue: 0,
          onChanged: model.setMouseSpeed,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Natural Scrolling'),
          actionDescription: 'Scrolling moves the content, not the view',
          value: model.mouseNaturalScroll,
          onChanged: model.setMouseNaturalScroll,
        ),
      ],
    );
  }
}
