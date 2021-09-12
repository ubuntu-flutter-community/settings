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
    final _model = Provider.of<MouseAndTouchpadModel>(context);

    return SettingsSection(
      headline: 'Touchpad',
      children: [
        SliderSettingsRow(
          actionLabel: 'Speed',
          value: _model.getTouchpadSpeed,
          min: -1,
          max: 1,
          onChanged: (value) => _model.setTouchpadSpeed(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Natural Scrolling',
          actionDescription: 'Scrolling moves the content, not the view',
          value: _model.getTouchpadNaturalScroll,
          onChanged: (value) => _model.setTouchpadNaturalScroll(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Tap To Click',
          value: _model.getTouchpadTapToClick,
          onChanged: (value) => _model.setTouchpadTapToClick(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Disable While Typing',
          value: _model.getTouchpadDisableWhileTyping,
          onChanged: (value) => _model.setTouchpadDisableWhileTyping(value),
        ),
      ],
    );
  }
}
