import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import 'package:settings/view/widgets/extra_options_gsettings_row.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/slider_settings_row.dart';
import 'package:settings/view/widgets/slider_settings_secondary.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class TypingSection extends StatelessWidget {
  const TypingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Typing',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Screen Keyboard',
          value: model.screenKeyboard,
          onChanged: (value) => model.setScreenKeyboard(value),
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
    final model = Provider.of<AccessibilityModel>(context);
    return ExtraOptionsGsettingsRow(
      actionLabel: 'Repeat Keys',
      actionDescription: 'Key presses repeat when key is held down',
      value: model.keyboardRepeat,
      onChanged: (value) => model.setKeyboardRepeat(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: model,
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
    final model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Repeat Keys')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SliderSettingsRow(
          actionLabel: 'Delay',
          actionDescription: 'Initial key repeat delay',
          value: model.delay,
          min: 100,
          max: 2000,
          defaultValue: 500,
          onChanged: (value) => model.setDelay(value),
        ),
        SliderSettingsRow(
          actionLabel: 'Interval',
          actionDescription: 'Delay between repeats',
          value: model.interval,
          min: 0,
          max: 110,
          defaultValue: 30,
          onChanged: (value) => model.setInterval(value),
        ),
      ],
    );
  }
}

class _CursorBlinking extends StatelessWidget {
  const _CursorBlinking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return ExtraOptionsGsettingsRow(
      actionLabel: 'Cursor Blinking',
      actionDescription: 'Cursor blinks in text fields',
      value: model.cursorBlink,
      onChanged: (value) => model.setCursorBlink(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: model,
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
    final model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Cursor Blinking')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SliderSettingsRow(
          actionLabel: 'Cursor Blink Time',
          actionDescription: 'Length of the cursor blink cycle',
          min: 100,
          max: 2500,
          value: model.cursorBlinkTime,
          onChanged: (value) => model.setCursorBlinkTime(value),
        ),
      ],
    );
  }
}

class _TypingAssist extends StatelessWidget {
  const _TypingAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);

    return SettingsRow(
      actionLabel: 'Typing Assist (AccessX)',
      secondChild: Row(
        children: [
          Text(model.typingAssistString),
          const SizedBox(width: 24.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: model,
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
    final model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Typing Assist')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SwitchSettingsRow(
          actionLabel: 'Enable by Keyboard',
          actionDescription:
              'Turn accessibility features on and off using the keyboard',
          value: model.keyboardEnable,
          onChanged: (value) => model.setKeyboardEnable(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Sticky Keys',
          actionDescription:
              'Treats a sequence of modifier keys as a key combination',
          value: model.stickyKeys,
          onChanged: (value) => model.setStickyKeys(value),
        ),
        const _StickyKeysSettings(),
        SwitchSettingsRow(
          actionLabel: 'Slow Keys',
          actionDescription:
              'Puts a delay between when a key is pressed and when it is accepted',
          value: model.slowKeys,
          onChanged: (value) => model.setSlowKeys(value),
        ),
        const _SlowKeysSettings(),
        SwitchSettingsRow(
          actionLabel: 'Bounce Keys',
          actionDescription: 'Ignores fast duplicate keypresses',
          value: model.bounceKeys,
          onChanged: (value) => model.setBounceKeys(value),
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
    final model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CheckboxRow(
            enabled: model.stickyKeys,
            value: model.stickyKeysTwoKey,
            onChanged: (value) => model.setStickyKeysTwoKey(value!),
            text: 'Disable if two keys are pressed at the same time',
          ),
          CheckboxRow(
            enabled: model.stickyKeys,
            value: model.stickyKeysBeep,
            onChanged: (value) => model.setStickyKeysBeep(value!),
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
    final model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SliderSettingsSecondary(
            label: 'Acceptance delay',
            enabled: model.slowKeys,
            min: 0,
            max: 500,
            value: model.slowKeysDelay,
            onChanged: (value) => model.setSlowKeysDelay(value),
          ),
          CheckboxRow(
            enabled: model.slowKeys,
            value: model.slowKeysBeepPress,
            onChanged: (value) => model.setSlowKeysBeepPress(value!),
            text: 'Beep when a key is pressed',
          ),
          CheckboxRow(
            enabled: model.slowKeys,
            value: model.slowKeysBeepAccept,
            onChanged: (value) => model.setSlowKeysBeepAccept(value!),
            text: 'Beep when a key is accepted',
          ),
          CheckboxRow(
            enabled: model.slowKeys,
            value: model.slowKeysBeepReject,
            onChanged: (value) => model.setSlowKeysBeepReject(value!),
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
    final model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SliderSettingsSecondary(
            label: 'Acceptance delay',
            enabled: model.bounceKeys,
            min: 0,
            max: 900,
            value: model.bounceKeysDelay,
            onChanged: (value) => model.setBounceKeysDelay(value),
          ),
          CheckboxRow(
            enabled: model.bounceKeys,
            value: model.bounceKeysBeepReject,
            onChanged: (value) => model.setBounceKeysBeepReject(value!),
            text: 'Beep when a key is rejected',
          ),
        ],
      ),
    );
  }
}
