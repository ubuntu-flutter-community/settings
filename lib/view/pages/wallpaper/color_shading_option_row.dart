import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class ColorShadingOptionRow extends StatelessWidget {
  const ColorShadingOptionRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.onDropDownChanged,
    required this.onExtraOptionButtonPressed,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final ColorShadingType value;
  final Function(ColorShadingType) onDropDownChanged;
  final VoidCallback onExtraOptionButtonPressed;

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();
    return SettingsRow(
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
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: onExtraOptionButtonPressed,
              child: const Icon(YaruIcons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
