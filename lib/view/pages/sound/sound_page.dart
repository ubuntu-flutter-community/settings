import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/sound/sound_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<SoundModel>(
      create: (_) => SoundModel(service),
      child: const SoundPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SoundModel>();

    return YaruPage(
      children: [
        YaruSection(
          width: kDefaultWidth,
          headline: 'System',
          children: [
            YaruSwitchRow(
              trailingWidget: const Text('Allow Volume Above 100%'),
              value: model.allowAbove100,
              onChanged: (value) => model.setAllowAbove100(value),
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Event Sounds'),
              actionDescription:
                  'Notify of a system action, notification or event',
              value: model.eventSounds,
              onChanged: (value) => model.setEventSounds(value),
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Input Feedback Sounds'),
              actionDescription: 'Feedback for user input events, '
                  'such as mouse clicks, or key presses',
              value: model.inputFeedbackSounds,
              onChanged: (value) => model.setInputFeedbackSounds(value),
            ),
          ],
        ),
      ],
    );
  }
}
