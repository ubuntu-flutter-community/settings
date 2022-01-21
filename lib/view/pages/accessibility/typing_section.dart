import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class TypingSection extends StatelessWidget {
  const TypingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: 'Typing',
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Screen Keyboard'),
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
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.settings,
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
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Repeat Keys',
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSliderRow(
          actionLabel: 'Delay',
          actionDescription: 'Initial key repeat delay',
          value: model.delay,
          min: 100,
          max: 2000,
          defaultValue: 500,
          onChanged: (value) => model.setDelay(value),
        ),
        YaruSliderRow(
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
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.settings,
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
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Cursor Blinking',
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSliderRow(
          actionLabel: 'Cursor Blink Time',
          actionDescription: 'Length of the cursor blink cycle',
          min: 100,
          max: 2500,
          defaultValue: 1200,
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
    final model = context.watch<AccessibilityModel>();

    return YaruRow(
      enabled: model.typingAssistAvailable,
      trailingWidget: const Text('Typing Assist (AccessX)'),
      actionWidget: Row(
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
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Typing Assist',
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Enable by Keyboard'),
          actionDescription:
              'Turn accessibility features on and off using the keyboard',
          value: model.keyboardEnable,
          onChanged: (value) => model.setKeyboardEnable(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Sticky Keys'),
          actionDescription:
              'Treats a sequence of modifier keys as a key combination',
          value: model.stickyKeys,
          onChanged: (value) => model.setStickyKeys(value),
        ),
        const _StickyKeysSettings(),
        YaruSwitchRow(
          trailingWidget: const Text('Slow Keys'),
          actionDescription:
              'Puts a delay between when a key is pressed and when it is accepted',
          value: model.slowKeys,
          onChanged: (value) => model.setSlowKeys(value),
        ),
        const _SlowKeysSettings(),
        YaruSwitchRow(
          trailingWidget: const Text('Bounce Keys'),
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
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          YaruCheckboxRow(
            enabled: model.stickyKeys ?? false,
            value: model.stickyKeysTwoKey ?? false,
            onChanged: (value) => model.setStickyKeysTwoKey(value!),
            text: 'Disable if two keys are pressed at the same time',
          ),
          YaruCheckboxRow(
            enabled: model.stickyKeys ?? false,
            value: model.stickyKeysBeep ?? false,
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
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 56,
            child: YaruSliderRow(
              enabled: model.slowKeys ?? false,
              actionLabel: 'Acceptance delay',
              value: model.slowKeysDelay,
              min: 0,
              max: 500,
              defaultValue: 300,
              onChanged: model.setSlowKeysDelay,
            ),
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepPress ?? false,
            onChanged: (value) => model.setSlowKeysBeepPress(value!),
            text: 'Beep when a key is pressed',
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepAccept ?? false,
            onChanged: (value) => model.setSlowKeysBeepAccept(value!),
            text: 'Beep when a key is accepted',
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepReject ?? false,
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
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 56,
            child: YaruSliderRow(
              enabled: model.bounceKeys ?? false,
              actionLabel: 'Acceptance delay',
              value: model.bounceKeysDelay,
              min: 0,
              max: 900,
              defaultValue: 300,
              onChanged: model.setBounceKeysDelay,
            ),
          ),
          YaruCheckboxRow(
            enabled: model.bounceKeys ?? false,
            value: model.bounceKeysBeepReject ?? false,
            onChanged: (value) => model.setBounceKeysBeepReject(value!),
            text: 'Beep when a key is rejected',
          ),
        ],
      ),
    );
  }
}
