import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
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
      headline: context.l10n.seeing,
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.highContrast),
          value: model.highContrast,
          onChanged: (value) => model.setHighContrast(value),
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.largeText),
          value: model.largeText,
          onChanged: (value) => model.setLargeText(value),
        ),
        const _CursorSize(),
        YaruExtraOptionRow(
          iconData: YaruIcons.settings,
          actionLabel: context.l10n.zoom,
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
          trailingWidget: Text(context.l10n.screenReader),
          actionDescription: context.l10n.screenReaderDescription,
          value: model.screenReader,
          onChanged: (value) => model.setScreenReader(value),
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.soundKeys),
          actionDescription: context.l10n.soundKeysDescription,
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
      title: Text(context.l10n.cursorSize),
      subtitle: Text(context.l10n.cursorSizeDescription),
      trailing: Row(
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
      title: context.l10n.cursorSize,
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
      title: context.l10n.zoomOptions,
      closeIconData: YaruIcons.window_close,
      children: [
        Text(
          context.l10n.zoomOption_Magnifier,
          style: Theme.of(context).textTheme.headline6,
        ),
        const _MagnifierOptions(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            context.l10n.zoomOption_Crosshairs,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const _CrosshairsOptions(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            context.l10n.zoomOption_ColorEffects,
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
          title: Text(context.l10n.magnification),
          trailing: SizedBox(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.l10n.magnifierPosition),
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
            title: context.l10n.followMouseCursor,
            value: true,
            enabled: true,
            groupValue: model.lensMode,
            onChanged: (bool? value) => model.setLensMode(value!),
          ),
          _RadioRow(
            title: context.l10n.screenPart,
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
                    value: item,
                  )
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
                  text: context.l10n.magnifierExtendsOutsideScreen,
                ),
                _RadioRow(
                  title: context.l10n.keepMagnifierCursorCentered,
                  value: 'centered',
                  groupValue: model.mouseTracking,
                  onChanged: (String? value) => model.setMouseTracking(value!),
                  enabled: model.screenPartEnabled,
                ),
                _RadioRow(
                  title: context.l10n.magnifierCursorPushesContentsAround,
                  value: 'push',
                  groupValue: model.mouseTracking,
                  onChanged: (String? value) => model.setMouseTracking(value!),
                  enabled: model.screenPartEnabled,
                ),
                _RadioRow(
                  title: context.l10n.magnifierCursorMovesWithContents,
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
          text: context.l10n.overlapsMouseCursor,
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: context.l10n.thickness,
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
            actionLabel: context.l10n.length,
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
          title: Text(context.l10n.color),
          trailing: YaruOptionButton.color(
            color: colorFromHex(model.crossHairsColor ?? '#FF0000'),
            onPressed: model.crossHairsColor != null
                ? () async {
                    final colorBeforeDialog = model.crossHairsColor;
                    if (!(await colorPickerDialog(context))) {
                      model.setCrossHairsColor(colorBeforeDialog!);
                    }
                  }
                : null,
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
        context.l10n.selectCrossHairsColor,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        context.l10n.selectColorShade,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        context.l10n.selectedColorsShade,
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
          text: context.l10n.whiteOnBlack,
        ),
        SizedBox(
          height: 56,
          child: YaruSliderRow(
            actionLabel: context.l10n.brightness,
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
            actionLabel: context.l10n.contrast,
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
            actionLabel: context.l10n.saturation,
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
