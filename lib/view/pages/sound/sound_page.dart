import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/sound/sound_model.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<SoundModel>(context);
    return Column(
      children: [
        SettingsSection(
          headline: 'System',
          children: [
            SwitchSettingsRow(
              actionLabel: 'Allow Volume Above 100%',
              value: _model.getAllowAbove100,
              onChanged: (value) => _model.setAllowAbove100(value),
            ),
            SwitchSettingsRow(
              actionLabel: 'Event Sounds',
              value: _model.getEventSounds,
              onChanged: (value) => _model.setEventSounds(value),
            ),
            SwitchSettingsRow(
              actionLabel: 'Input Feedback Sounds',
              value: _model.getInputFeedbackSounds,
              onChanged: (value) => _model.setInputFeedbackSounds(value),
            ),
          ],
        ),
      ],
    );
  }
}
