import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/extra_options_gsettings_row.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

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
        const _CursorBlinking(),
        const _TypingAssist(),
      ],
    );
  }
}

class _RepeatKeys extends StatelessWidget {
  const _RepeatKeys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return ExtraOptionsGsettingsRow(
      actionLabel: 'Repeat Keys',
      actionDescription: 'Key presses repeat when key is held down',
      value: _model.getKeyboardRepeat,
      onChanged: (value) => _model.setKeyboardRepeat(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: _model,
          child: const _RepeatKeysSettings(),
        ),
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

class _CursorBlinking extends StatelessWidget {
  const _CursorBlinking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return ExtraOptionsGsettingsRow(
      actionLabel: 'Cursor Blinking',
      actionDescription: 'Cursor blinks in text fields',
      value: _model.getCursorBlink,
      onChanged: (value) => _model.setCursorBlink(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: _model,
          child: const _CursorBlinkingSettings(),
        ),
      ),
    );
  }
}

class _CursorBlinkingSettings extends StatelessWidget {
  const _CursorBlinkingSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Cursor Blinking')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SettingsRow(
          actionLabel: 'Cursor Blink Time',
          actionDescription: 'Length of the cursor blink cycle',
          secondChild: Expanded(
            child: Slider(
              min: 100,
              max: 2500,
              value: _model.getCursorBlinkTime,
              onChanged: (value) {
                _model.setCursorBlinkTime(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TypingAssist extends StatelessWidget {
  const _TypingAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);

    return SettingsRow(
      actionLabel: 'Typing Assist (AccessX)',
      secondChild: Row(
        children: [
          _model.getTypingAssist ? const Text('On') : const Text('Off'),
          const SizedBox(width: 24.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: _model,
                  child: const _TypingAssistSettings(),
                ),
              ),
              child: const Icon(YaruIcons.settings),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingAssistSettings extends StatelessWidget {
  const _TypingAssistSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Typing Assist')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SwitchSettingsRow(
          actionLabel: 'Enable by Keyboard',
          actionDescription:
              'Turn accessibility features on and off using the keyboard',
          value: _model.getKeyboardEnable,
          onChanged: (value) => _model.setKeyboardEnable(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Sticky Keys',
          actionDescription:
              'Treats a sequence of modifier keys as a key combination',
          value: _model.getStickyKeys,
          onChanged: (value) => _model.setStickyKeys(value),
        ),
        const _StickyKeysSettings(),
        SwitchSettingsRow(
          actionLabel: 'Slow Keys',
          actionDescription:
              'Puts a delay between when a key is pressed and when it is accepted',
          value: _model.getSlowKeys,
          onChanged: (value) => _model.setSlowKeys(value),
        ),
        const _SlowKeysSettings(),
        SwitchSettingsRow(
          actionLabel: 'Bounce Keys',
          actionDescription: 'Ignores fast duplicate keypresses',
          value: _model.getBounceKeys,
          onChanged: (value) => _model.setBounceKeys(value),
        ),
        const _BounceKeysSettings(),
      ],
    );
  }
}

class _StickyKeysSettings extends StatelessWidget {
  const _StickyKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          _CheckboxRow(
            enabled: _model.getStickyKeys,
            value: _model.getStickyKeysTwoKey,
            onChanged: (value) => _model.setStickyKeysTwoKey(value!),
            text: 'Disable if two keys are pressed at the same time',
          ),
          _CheckboxRow(
            enabled: _model.getStickyKeys,
            value: _model.getStickyKeysBeep,
            onChanged: (value) => _model.setStickyKeysBeep(value!),
            text: 'Beep when a modifier key is pressed',
          ),
        ],
      ),
    );
  }
}

class _SlowKeysSettings extends StatelessWidget {
  const _SlowKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Acceptance delay',
                  style: _model.getSlowKeys
                      ? null
                      : TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 500,
                  value: _model.getSlowKeysDelay,
                  onChanged: _model.getSlowKeys
                      ? (value) {
                          _model.setSlowKeysDelay(value);
                        }
                      : null,
                ),
              ),
            ],
          ),
          _CheckboxRow(
            enabled: _model.getSlowKeys,
            value: _model.getSlowKeysBeepPress,
            onChanged: (value) => _model.setSlowKeysBeepPress(value!),
            text: 'Beep when a key is pressed',
          ),
          _CheckboxRow(
            enabled: _model.getSlowKeys,
            value: _model.getSlowKeysBeepAccept,
            onChanged: (value) => _model.setSlowKeysBeepAccept(value!),
            text: 'Beep when a key is accepted',
          ),
          _CheckboxRow(
            enabled: _model.getSlowKeys,
            value: _model.getSlowKeysBeepReject,
            onChanged: (value) => _model.setSlowKeysBeepReject(value!),
            text: 'Beep when a key is rejected',
          ),
        ],
      ),
    );
  }
}

class _BounceKeysSettings extends StatelessWidget {
  const _BounceKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Acceptance delay',
                  style: _model.getBounceKeys
                      ? null
                      : TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 900,
                  value: _model.getBounceKeysDelay,
                  onChanged: _model.getBounceKeys
                      ? (value) => _model.setBounceKeysDelay(value)
                      : null,
                ),
              ),
            ],
          ),
          _CheckboxRow(
            enabled: _model.getBounceKeys,
            value: _model.getBounceKeysBeepReject,
            onChanged: (value) => _model.setBounceKeysBeepReject(value!),
            text: 'Beep when a key is rejected',
          ),
        ],
      ),
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({
    Key? key,
    required this.enabled,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final bool enabled;
  final bool value;
  final Function(bool?) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: enabled ? onChanged : null,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: enabled
                ? null
                : TextStyle(color: Theme.of(context).disabledColor),
          ),
        ),
      ],
    );
  }
}
