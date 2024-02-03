import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ColorShadingOptionRow extends StatelessWidget {
  const ColorShadingOptionRow({
    super.key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.onDropDownChanged,
    this.width,
  });

  final String actionLabel;
  final String? actionDescription;
  final ColorShadingType value;
  final Function(ColorShadingType) onDropDownChanged;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();
    return SizedBox(
      width: width,
      child: YaruTile(
        title: Text(actionLabel),
        subtitle: actionDescription != null ? Text(actionDescription!) : null,
        trailing: Row(
          children: [
            YaruPopupMenuButton<ColorShadingType>(
              initialValue: model.colorShadingType,
              child: Text(model.colorShadingType.localize(context.l10n)),
              itemBuilder: (context) {
                return [
                  for (final type in ColorShadingType.values)
                    PopupMenuItem(
                      value: type,
                      onTap: () => model.colorShadingType = type,
                      child: Text(type.localize(context.l10n)),
                    ),
                ];
              },
            ),
            const SizedBox(width: 8.0),
            YaruOptionButton.color(
              color: colorFromHex(model.primaryColor),
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
              YaruOptionButton.color(
                color: colorFromHex(model.secondaryColor),
                onPressed: () async {
                  final colorBeforeDialog = model.secondaryColor;
                  if (!(await colorPickerDialog(context, false))) {
                    model.secondaryColor = colorBeforeDialog;
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog(BuildContext context, bool primary) async {
    final model = context.read<WallpaperModel>();
    return ColorPicker(
      color: colorFromHex(primary ? model.primaryColor : model.secondaryColor),
      onColorChanged: (color) => {
        if (primary)
          {model.primaryColor = '#${color.hex}'}
        else
          {model.secondaryColor = '#${color.hex}'},
      },
      width: 40,
      height: 40,
      borderRadius: 8,
      spacing: 10,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        primary
            ? context.l10n.wallpaperPagePickerTitlePrimary
            : context.l10n.wallpaperPagePickerTitleSecondary,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      wheelSubheading: Text(
        context.l10n.wallpaperPagePickerWheelHeading,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 300, minWidth: 300, maxWidth: 320),
    );
  }
}
