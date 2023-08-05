import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/pages/sound/sound_model.dart';
import 'package:settings/view/settings_section.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<SoundModel>(
      create: (_) => SoundModel(service),
      child: const SoundPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.soundPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.soundPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SoundModel>();

    return SettingsPage(
      children: [
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('System'),
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
