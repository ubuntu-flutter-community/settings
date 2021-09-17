import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/slider_settings_row.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class TouchpadSection extends StatelessWidget {
  const TouchpadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MouseAndTouchpadModel>(context);

    return SettingsSection(
      headline: 'Touchpad',
      children: [
        SliderSettingsRow(
          actionLabel: 'Speed',
          value: model.touchpadSpeed,
          min: -1,
          max: 1,
          onChanged: (value) => model.setTouchpadSpeed(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Natural Scrolling',
          actionDescription: 'Scrolling moves the content, not the view',
          value: model.touchpadNaturalScroll,
          onChanged: (value) => model.setTouchpadNaturalScroll(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Tap To Click',
          value: model.touchpadTapToClick,
          onChanged: (value) => model.setTouchpadTapToClick(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Disable While Typing',
          value: model.touchpadDisableWhileTyping,
          onChanged: (value) => model.setTouchpadDisableWhileTyping(value),
        ),
      ],
    );
  }
}
