import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/slider_settings_row.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class MouseSection extends StatelessWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MouseAndTouchpadModel>(context);

    return SettingsSection(
      headline: 'Mouse',
      children: [
        SliderSettingsRow(
          actionLabel: 'Speed',
          value: _model.getMouseSpeed,
          min: -1,
          max: 1,
          onChanged: (value) => _model.setMouseSpeed(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Natural Scrolling',
          actionDescription: 'Scrolling moves the content, not the view',
          value: _model.getMouseNaturalScroll,
          onChanged: (value) => _model.setMouseNaturalScroll(value),
        ),
      ],
    );
  }
}
