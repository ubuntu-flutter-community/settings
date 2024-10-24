import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/pages/sound/sound_model.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<SoundModel>(
      create: (_) => SoundModel(di<GSettingsService>()),
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
              onChanged: model.setAllowAbove100,
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Event Sounds'),
              actionDescription:
                  'Notify of a system action, notification or event',
              value: model.eventSounds,
              onChanged: model.setEventSounds,
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Input Feedback Sounds'),
              actionDescription: 'Feedback for user input events, '
                  'such as mouse clicks, or key presses',
              value: model.inputFeedbackSounds,
              onChanged: model.setInputFeedbackSounds,
            ),
          ],
        ),
      ],
    );
  }
}
