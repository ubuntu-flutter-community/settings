import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ColorShadingOptionRow extends StatelessWidget {
  const ColorShadingOptionRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.onDropDownChanged,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final ColorShadingType value;
  final Function(ColorShadingType) onDropDownChanged;

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();
    return YaruRow(
      trailingWidget: Text(actionLabel),
      description: actionDescription,
      actionWidget: Row(
        children: [
          DropdownButton<ColorShadingType>(
            onChanged: (value) => model.colorShadingType = value,
            value: value,
            items: const [
              DropdownMenuItem(
                child: Text('solid color'),
                value: ColorShadingType.solid,
              ),
              DropdownMenuItem(
                child: Text('horizontal gradient'),
                value: ColorShadingType.horizontal,
              ),
              DropdownMenuItem(
                child: Text('vertical gradient'),
                value: ColorShadingType.vertical,
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          ColorPickerButton(
            color: fromHex(model.primaryColor),
            onPressed: () async {
              final colorBeforeDialog = model.primaryColor;
              if (!(await colorPickerDialog(context, true))) {
                model.primaryColor = colorBeforeDialog;
              }
            },
          ),
          if (model.colorShadingType != ColorShadingType.solid)
            const SizedBox(width: 8.0),
          if (model.colorShadingType != ColorShadingType.solid)
            ColorPickerButton(
                color: fromHex(model.secondaryColor),
                onPressed: () async {
                  final colorBeforeDialog = model.secondaryColor;
                  if (!(await colorPickerDialog(context, false))) {
                    model.secondaryColor = colorBeforeDialog;
                  }
                }),
        ],
      ),
    );
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0);
  }

  Future<bool> colorPickerDialog(BuildContext context, bool primary) async {
    final model = context.read<WallpaperModel>();
    return ColorPicker(
      color: fromHex(primary ? model.primaryColor : model.secondaryColor),
      onColorChanged: (Color color) => {
        if (primary)
          {model.primaryColor = '#' + color.hex}
        else
          {model.secondaryColor = '#' + color.hex}
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        primary ? 'Select a primary color' : 'Select a secondary color',
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

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const size = 40.0;
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
        onPressed: onPressed,
        child: SizedBox(
          width: size / 2,
          height: size / 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: color),
          ),
        ),
      ),
    );
  }
}
