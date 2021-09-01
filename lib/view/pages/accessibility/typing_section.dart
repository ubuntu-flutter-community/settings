import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class TypingSection extends StatelessWidget {
  const TypingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Typing',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Screen Keyboard',
          value: _model.getScreenKeyboard,
          onChanged: (value) => _model.setScreenKeyboard(value),
        ),
        const _RepeatKeys(),
      ],
    );
  }
}

class _RepeatKeys extends StatelessWidget {
  const _RepeatKeys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ChangeNotifierProvider.value(
            value: _model,
            child: const _RepeatKeysSettings(),
          ),
        );
      },
      child: SettingsRow(
        actionLabel: 'Repeat Keys',
        secondChild:
            _model.getKeyboardRepeat ? const Text('On') : const Text('Off'),
      ),
    );
  }
}

class _RepeatKeysSettings extends StatelessWidget {
  const _RepeatKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Repeat Keys')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SwitchSettingsRow(
          actionLabel: 'Repeat Keys',
          actionDescription: 'Key presses repeat when key is held down.',
          value: _model.getKeyboardRepeat,
          onChanged: (value) => _model.setKeyboardRepeat(value),
        ),
        SettingsRow(
          actionLabel: 'Delay',
          actionDescription: 'Initial key repeat delay',
          secondChild: Expanded(
            child: Slider(
              min: 100,
              max: 2000,
              value: _model.getDelay,
              onChanged: (value) {
                _model.setDelay(value);
              },
            ),
          ),
        ),
        SettingsRow(
          actionLabel: 'Interval',
          actionDescription: 'Delay between repeats',
          secondChild: Expanded(
            child: Slider(
              min: 0.0,
              max: 110.0,
              value: _model.getInterval,
              onChanged: (value) {
                _model.setInterval(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
