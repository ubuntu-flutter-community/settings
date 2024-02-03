import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_slider_row.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';

class TouchpadSection extends StatelessWidget {
  const TouchpadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MouseAndTouchpadModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('Touchpad'),
      children: [
        YaruSliderRow(
          actionLabel: 'Speed',
          value: model.touchpadSpeed,
          showValue: false,
          min: -1,
          max: 1,
          defaultValue: 0,
          onChanged: model.setTouchpadSpeed,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Natural Scrolling'),
          actionDescription: 'Scrolling moves the content, not the view',
          value: model.touchpadNaturalScroll,
          onChanged: model.setTouchpadNaturalScroll,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Tap To Click'),
          value: model.touchpadTapToClick,
          onChanged: model.setTouchpadTapToClick,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Disable While Typing'),
          value: model.touchpadDisableWhileTyping,
          onChanged: model.setTouchpadDisableWhileTyping,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Two-finger Scrolling'),
          value: model.twoFingerScrolling,
          onChanged: model.setTwoFingerScrolling,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Edge Scrolling'),
          value: model.edgeScrolling,
          onChanged: model.setEdgeScrolling,
        ),
      ],
    );
  }
}
