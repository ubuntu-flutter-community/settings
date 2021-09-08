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
    return SimpleDialog(
      title: const Center(child: Text('Zoom Options')),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        Text(
          'Magnifier',
          style: Theme.of(context).textTheme.headline6,
        ),
        const _MagnifierOptions(),
        Text(
          'Crosshairs',
          style: Theme.of(context).textTheme.headline6,
        ),
        const _CrosshairsOptions(),
        Text(
          'Color Effects',
          style: Theme.of(context).textTheme.headline6,
        ),
        const _ColorEffectsOptions(),
      ],
    );
  }
}

class _MagnifierOptions extends StatelessWidget {
  const _MagnifierOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Magnification'),
              ),
              Expanded(
                // TODO it'd be better to use SpinBox instead of Slider
                child: Slider(
                  min: 1,
                  max: 20,
                  value: _model.getMagFactor,
                  onChanged: (value) => _model.setMagFactor(value),
                ),
              ),
            ],
          ),
          const Text('Magnifier Position'),
          const _MagnifierPositionOptions(),
        ],
      ),
    );
  }
}

class _MagnifierPositionOptions extends StatelessWidget {
  const _MagnifierPositionOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return Column(
      children: [
        _RadioRow(
          title: 'Follow mouse cursor',
          value: true,
          groupValue: _model.getLensMode,
          onChanged: (bool? value) => _model.setLensMode(value!),
        ),
        _RadioRow(
          title: 'Screen part',
          value: false,
          groupValue: _model.getLensMode,
          onChanged: (bool? value) => _model.setLensMode(value!),
          secondary: DropdownButton<String>(
            onChanged: _model.getLensMode
                ? null
                : (value) => _model.setScreenPosition(value!),
            value: _model.getScreenPosition,
            items: const [
              DropdownMenuItem(
                value: 'full-screen',
                child: Text('Full Screen'),
              ),
              DropdownMenuItem(
                value: 'top-half',
                child: Text('Top Half'),
              ),
              DropdownMenuItem(
                value: 'bottom-half',
                child: Text('Bottom Half'),
              ),
              DropdownMenuItem(
                value: 'left-half',
                child: Text('Left Half'),
              ),
              DropdownMenuItem(
                value: 'right-half',
                child: Text('Right Half'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CheckboxRow(
                enabled: !_model.getLensMode,
                value: _model.getScrollAtEdges,
                onChanged: (value) => _model.setScrollAtEdges(value!),
                text: 'Magnifier extends outside of screen',
              ),
              _RadioRow(
                title: 'Keep magnifier cursor centered',
                value: 'centered',
                groupValue: _model.getMouseTracking,
                onChanged: (String? value) => _model.setMouseTracking(value!),
                enabled: !_model.getLensMode,
              ),
              _RadioRow(
                title: 'Magnifier cursor pushes contents around',
                value: 'push',
                groupValue: _model.getMouseTracking,
                onChanged: (String? value) => _model.setMouseTracking(value!),
                enabled: !_model.getLensMode,
              ),
              _RadioRow(
                title: 'Magnifier cursor moves with contents',
                value: 'proportional',
                groupValue: _model.getMouseTracking,
                onChanged: (String? value) => _model.setMouseTracking(value!),
                enabled: !_model.getLensMode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RadioRow<T> extends StatelessWidget {
  const _RadioRow({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
    this.secondary,
  }) : super(key: key);

  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: enabled ? onChanged : null,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: enabled
                ? null
                : TextStyle(color: Theme.of(context).disabledColor),
          ),
        ),
        if (secondary != null) secondary!,
      ],
    );
  }
}

class _CrosshairsOptions extends StatelessWidget {
  const _CrosshairsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        children: [
          CheckboxRow(
            enabled: true,
            value: _model.getCrossHairs,
            onChanged: (value) => _model.setCrossHairs(value!),
            text: 'Visible',
          ),
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
                  min: 1,
                  max: 100,
                  value: _model.getCrossHairsThickness,
                  onChanged: (value) => _model.setCrossHairsThickness(value),
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
                  min: 20,
                  max: 4096,
                  value: _model.getCrossHairsLength,
                  onChanged: (value) => _model.setCrossHairsLength(value),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Text('Color'),
              ),
              // TODO We need Color selector widget
              OutlinedButton(
                onPressed: null,
                child: Text('Color'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorEffectsOptions extends StatelessWidget {
  const _ColorEffectsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
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
                  min: -0.75,
                  max: 0.75,
                  value: _model.getColorBrightness,
                  onChanged: (value) => _model.setColorBrightness(value),
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
                  min: -0.75,
                  max: 0.75,
                  value: _model.getColorContrast,
                  onChanged: (value) => _model.setColorContrast(value),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Text('Saturation'),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 1,
                  value: _model.getColorSaturation,
                  onChanged: (value) => _model.setColorSaturation(value),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
