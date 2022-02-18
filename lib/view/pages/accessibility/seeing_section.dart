import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'package:yaru_icons/yaru_icons.dart';

class SeeingSection extends StatelessWidget {
  const SeeingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: 'Seeing',
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('High Contrast'),
          value: model.highContrast,
          onChanged: (value) => model.setHighContrast(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Large Text'),
          value: model.largeText,
          onChanged: (value) => model.setLargeText(value),
        ),
        const _CursorSize(),
        YaruExtraOptionRow(
          iconData: YaruIcons.settings,
          actionLabel: 'Zoom',
          value: model.zoom,
          onChanged: (value) => model.setZoom(value),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => ChangeNotifierProvider.value(
              value: model,
              child: const _ZoomSettings(),
            ),
          ),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Screen Reader'),
          actionDescription:
              'The screen reader reads displayed text as you move the focus',
          value: model.screenReader,
          onChanged: (value) => model.setScreenReader(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Sound Keys'),
          actionDescription:
              'Beep when Num Lock or Caps Lock are turned on or off',
          value: model.toggleKeys,
          onChanged: (value) => model.setToggleKeys(value),
        ),
      ],
    );
  }
}

class _CursorSize extends StatelessWidget {
  const _CursorSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruRow(
      enabled: model.cursorSize != null,
      trailingWidget: const Text('Cursor Size'),
      description: 'Cursor size can be combined with zoom '
          'to make it easier to see the cursor',
      actionWidget: Row(
        children: [
          const SizedBox(width: 24.0),
          Text(model.cursorSizeString()),
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
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth / 2,
      title: 'Cursor Size',
      closeIconData: YaruIcons.window_close,
      children: [
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_24px.png',
          onPressed: () => model.setCursorSize(24),
          selected: model.cursorSize == 24,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_32px.png',
          onPressed: () => model.setCursorSize(32),
          selected: model.cursorSize == 32,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_48px.png',
          onPressed: () => model.setCursorSize(48),
          selected: model.cursorSize == 48,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_64px.png',
          onPressed: () => model.setCursorSize(64),
          selected: model.cursorSize == 64,
        ),
        _CursorButton(
          imageName: 'assets/images/cursor/left_ptr_96px.png',
          onPressed: () => model.setCursorSize(96),
          selected: model.cursorSize == 96,
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
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Zoom Options',
      closeIconData: YaruIcons.window_close,
      children: [
        Text(
          'Magnifier',
          style: Theme.of(context).textTheme.headline6,
        ),
        const _MagnifierOptions(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Crosshairs',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const _CrosshairsOptions(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Color Effects',
            style: Theme.of(context).textTheme.headline6,
          ),
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
    final model = context.watch<AccessibilityModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YaruRow(
          enabled: model.magFactor != null,
          trailingWidget: const Text('Magnification'),
          actionWidget: SizedBox(
            height: 40,
            width: 150,
            child: SpinBox(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              enabled: true,
              min: 1,
              max: 20,
              step: 0.25,
              decimals: 2,
              value: model.magFactor ?? 2,
              onChanged: (value) => model.setMagFactor(value),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Magnifier Position'),
        ),
        const _MagnifierPositionOptions(),
      ],
    );
  }
}

class _MagnifierPositionOptions extends StatelessWidget {
  const _MagnifierPositionOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _RadioRow(
            title: 'Follow mouse cursor',
            value: true,
            enabled: true,
            groupValue: model.lensMode,
            onChanged: (bool? value) => model.setLensMode(value!),
          ),
          _RadioRow(
            title: 'Screen part',
            enabled: true,
            value: false,
            groupValue: model.lensMode,
            onChanged: (bool? value) => model.setLensMode(value!),
            secondary: DropdownButton<String>(
              onChanged: !model.screenPartEnabled
                  ? null
                  : (value) => model.setScreenPosition(value!),
              value: model.screenPosition,
              items: [
                for (var item in AccessibilityModel.screenPositions)
                  DropdownMenuItem(
                      child: Text(item.toLowerCase().replaceAll('-', ' ')),
                      value: item)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                YaruCheckboxRow(
                  enabled: model.screenPartEnabled,
                  value: model.scrollAtEdges ?? false,
                  onChanged: (value) => model.setScrollAtEdges(value!),
                  text: 'Magnifier extends outside of screen',
                ),
                _RadioRow(
                  title: 'Keep magnifier cursor centered',
                  value: 'centered',
                  groupValue: model.mouseTracking,
                  onChanged: (String? value) => model.setMouseTracking(value!),
                  enabled: model.screenPartEnabled,
                ),
                _RadioRow(
                  title: 'Magnifier cursor pushes contents around',
                  value: 'push',
                  groupValue: model.mouseTracking,
                  onChanged: (String? value) => model.setMouseTracking(value!),
                  enabled: model.screenPartEnabled,
                ),
                _RadioRow(
                  title: 'Magnifier cursor moves with contents',
                  value: 'proportional',
                  groupValue: model.mouseTracking,
                  onChanged: (String? value) => model.setMouseTracking(value!),
                  enabled: model.screenPartEnabled,
                ),
              ],
            ),
          ),
        ],
      ),
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
    required this.enabled,
    this.secondary,
  }) : super(key: key);

  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool? enabled;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    final _value = value;
    final _enabled = enabled;

    if (_value == null || _enabled == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Radio(
          value: _value,
          groupValue: groupValue,
          onChanged: _enabled ? onChanged : null,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: _enabled
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
    final model = context.watch<AccessibilityModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YaruCheckboxRow(
          enabled: model.crossHairs != null,
          value: model.crossHairs ?? false,
          onChanged: (value) => model.setCrossHairs(value!),
          text: 'Visible',
        ),
        const SizedBox(height: 8),
        YaruCheckboxRow(
          enabled: model.crossHairsClip != null,
          value: model.crossHairsClip ?? false,
          onChanged: (value) => model.setCrossHairsClip(value!),
          text: 'Overlaps mouse cursor',
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: 'Thickness',
            value: model.crossHairsThickness,
            min: 1,
            max: 100,
            defaultValue: 8,
            onChanged: model.setCrossHairsThickness,
            showValue: false,
          ),
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: 'Length',
            value: model.crossHairsLength,
            min: 20,
            max: 4096,
            defaultValue: 4096,
            onChanged: model.setCrossHairsLength,
            showValue: false,
          ),
        ),
        YaruRow(
          enabled: model.crossHairsColor != null,
          trailingWidget: const Text('Color'),
          actionWidget: YaruColorPickerButton(
            enabled: model.crossHairsColor != null,
            color: colorFromHex(model.crossHairsColor ?? '#FF0000'),
            onPressed: () async {
              final colorBeforeDialog = model.crossHairsColor;
              if (!(await colorPickerDialog(context))) {
                model.setCrossHairsColor(colorBeforeDialog!);
              }
            },
          ),
        ),
      ],
    );
  }

  Future<bool> colorPickerDialog(BuildContext context) async {
    final model = context.read<AccessibilityModel>();
    return ColorPicker(
      color: colorFromHex(model.crossHairsColor ?? '#FF0000'),
      onColorChanged: (value) => model.setCrossHairsColor('#${value.hex}'),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select crosshairs color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
      colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}

class _ColorEffectsOptions extends StatelessWidget {
  const _ColorEffectsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YaruCheckboxRow(
          enabled: model.inverseLightness != null,
          value: model.inverseLightness ?? false,
          onChanged: (value) => model.setInverseLightness(value!),
          text: 'White on black',
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: 'Brightness',
            value: model.colorBrightness,
            min: -0.75,
            max: 0.75,
            defaultValue: 0,
            onChanged: model.setColorBrightness,
            showValue: false,
          ),
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: 'Contrast',
            value: model.colorContrast,
            min: -0.75,
            max: 0.75,
            defaultValue: 0,
            onChanged: model.setColorContrast,
            showValue: false,
          ),
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: 'Saturation',
            value: model.colorSaturation,
            min: 0,
            max: 1,
            defaultValue: 1,
            onChanged: model.setColorSaturation,
            showValue: false,
          ),
        ),
      ],
    );
  }
}
