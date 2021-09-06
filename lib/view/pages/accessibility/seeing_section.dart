import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import 'package:settings/view/widgets/extra_options_gsettings_row.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class SeeingSection extends StatelessWidget {
  const SeeingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Seeing',
      children: [
        SwitchSettingsRow(
          actionLabel: 'High Contrast',
          value: _model.getHighContrast,
          onChanged: (value) => _model.setHighContrast(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Large Text',
          value: _model.getLargeText,
          onChanged: (value) => _model.setLargeText(value),
        ),
        const _CursorSize(),
        ExtraOptionsGsettingsRow(
          actionLabel: 'Zoom',
          value: _model.getZoom,
          onChanged: (value) => _model.setZoom(value),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => ChangeNotifierProvider.value(
              value: _model,
              child: const _ZoomSettings(),
            ),
          ),
        ),
        SwitchSettingsRow(
          actionLabel: 'Screen Reader',
          actionDescription:
              'The screen reader reads displayed text as you move the focus',
          value: _model.getScreenReader,
          onChanged: (value) => _model.setScreenReader(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Sound Keys',
          actionDescription:
              'Beep when Num Lock or Caps Lock are turned on or off',
          value: _model.getToggleKeys,
          onChanged: (value) => _model.setToggleKeys(value),
        ),
      ],
    );
  }
}

class _CursorSize extends StatelessWidget {
  const _CursorSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsRow(
      actionLabel: 'Cursor Size',
      actionDescription: 'Cursor size can be combined with zoom '
          'to make it easier to see the cursor',
      secondChild: Row(
        children: [
          const SizedBox(width: 24.0),
          Text(_model.cursorSize()),
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
                  child: const _CursorSizeSettings(),
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

class _CursorSizeSettings extends StatelessWidget {
  const _CursorSizeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Cursor Size')),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_24px.png',
          onPressed: () => _model.setCursorSize(24),
          selected: _model.getCursorSize == 24,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_32px.png',
          onPressed: () => _model.setCursorSize(32),
          selected: _model.getCursorSize == 32,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_48px.png',
          onPressed: () => _model.setCursorSize(48),
          selected: _model.getCursorSize == 48,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_64px.png',
          onPressed: () => _model.setCursorSize(64),
          selected: _model.getCursorSize == 64,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_96px.png',
          onPressed: () => _model.setCursorSize(96),
          selected: _model.getCursorSize == 96,
        ),
      ],
    );
  }
}

class _CursorButton extends StatelessWidget {
  const _CursorButton({
    Key? key,
    required this.imageName,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);

  final String imageName;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          width: 100,
          height: 100,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.onSurface.withAlpha(
                        selected ? 60 : 0,
                      ),
            ),
            onPressed: onPressed,
            child: Image.asset(imageName),
          ),
        ),
      ),
    );
  }
}

class _ZoomSettings extends StatelessWidget {
  const _ZoomSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Zoom Options')),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        const Text('Magnification'), // TODO use real widget
        const Text('Magnifier Position'),
        const _MagnifierPositionOptions(),
        SwitchSettingsRow(
          actionLabel: 'Crosshairs',
          value: _model.getCrossHairs,
          onChanged: (value) => _model.setCrossHairs(value),
        ),
        const _CrosshairsOptions(),
        const Text('Color Effects'),
        const _ColorEffectsOptions(),
      ],
    );
  }
}

class _MagnifierPositionOptions extends StatelessWidget {
  const _MagnifierPositionOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _CrosshairsOptions extends StatelessWidget {
  const _CrosshairsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);

    return Column(
      children: [
        CheckboxRow(
          enabled: true,
          value: _model.getCrossHairsClip,
          onChanged: (value) => _model.setCrossHairsClip(value!),
          text: 'Overlaps mouse cursor',
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Thickness'),
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: 900,
                value: 0, // TODO,
                onChanged: (_) {}, // TODO
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Length'),
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: 900,
                value: 0, // TODO,
                onChanged: (_) {}, // TODO
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Expanded(
              child: Text('Color'),
            ),
            OutlinedButton(
              onPressed: null,
              child: Text('FIX ME'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ColorEffectsOptions extends StatelessWidget {
  const _ColorEffectsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);

    return Column(
      children: [
        CheckboxRow(
          enabled: true,
          value: _model.getInverseLightness,
          onChanged: (value) => _model.setInverseLightness(value!),
          text: 'White on black',
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Brightness'),
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: 900,
                value: 0, // TODO,
                onChanged: (_) {}, // TODO
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Contrast'),
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: 900,
                value: 0, // TODO,
                onChanged: (_) {}, // TODO
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Color'),
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: 900,
                value: 0, // TODO,
                onChanged: (_) {}, // TODO
              ),
            ),
          ],
        )
      ],
    );
  }
}
