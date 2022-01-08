import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/appearance/appearance_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DockSection extends StatelessWidget {
  const DockSection({Key? key}) : super(key: key);
  static const assetHeight = 80.0;
  static const assetPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppearanceModel>(context);

    return Column(
      children: [
        YaruSection(
          headline: 'Dock appearance',
          children: [
            YaruRow(
                trailingWidget: const Text('Panel mode'),
                description:
                    'Extends the height of the dock to become a panel.',
                actionWidget: Radio<bool>(
                    value: true,
                    groupValue: model.extendDock,
                    onChanged: (value) => model.extendDock = value),
                enabled: model.extendDock != null),
            Padding(
              padding: const EdgeInsets.all(assetPadding),
              child: SvgPicture.asset(
                'assets/images/panel-mode.svg',
                color: (model.extendDock != null && model.extendDock == true)
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).backgroundColor,
                colorBlendMode: BlendMode.color,
                height: assetHeight,
              ),
            ),
            YaruRow(
                trailingWidget: const Text('Dock mode'),
                description:
                    'Displays the dock in a centered, free-floating mode.',
                actionWidget: Radio<bool>(
                    value: false,
                    groupValue: model.extendDock,
                    onChanged: (value) => model.extendDock = value!),
                enabled: true),
            Padding(
              padding: const EdgeInsets.all(assetPadding),
              child: SvgPicture.asset(
                'assets/images/dock-mode.svg',
                color: (model.extendDock != null && !model.extendDock!)
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).backgroundColor,
                colorBlendMode: BlendMode.color,
                height: assetHeight,
              ),
            ),
            YaruSwitchRow(
                trailingWidget: const Text('Compact look'),
                actionDescription: 'Slims the dock to use less space.',
                value: model.customThemeShrink ?? false,
                onChanged: (value) => model.customThemeShrink = value)
          ],
        ),
        YaruSection(
          headline: 'Dock options',
          children: [
            Column(
              children: [
                YaruSwitchRow(
                  enabled: model.alwaysShowDock != null,
                  trailingWidget: const Text('Auto-hide the Dock'),
                  actionDescription: 'The dock hides when windows touch it.',
                  value: model.alwaysShowDock != null &&
                      model.alwaysShowDock == false,
                  onChanged: (value) => model.alwaysShowDock = !value,
                ),
                Padding(
                  padding: const EdgeInsets.all(assetPadding),
                  child: SvgPicture.asset(
                    'assets/images/auto-hide.svg',
                    color:
                        (model.alwaysShowDock != null && !model.alwaysShowDock!)
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Theme.of(context).backgroundColor,
                    colorBlendMode: BlendMode.color,
                    height: assetHeight,
                  ),
                )
              ],
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Show Trash'),
              actionDescription: 'Show the trash on the dock',
              value: model.showTrash,
              onChanged: (value) => model.showTrash = value,
            ),
            YaruSwitchRow(
              trailingWidget: const Text('Active App Glow'),
              actionDescription:
                  'Colors active app icons in their primary accent color.',
              value: model.appGlow,
              onChanged: (value) => model.appGlow = value,
            ),
            YaruSliderRow(
              actionLabel: 'Icon Size',
              value: model.maxIconSize ?? 48.0,
              min: 16,
              max: 64,
              defaultValue: 48,
              onChanged: (value) => model.maxIconSize = value,
            ),
            YaruRow(
              enabled: model.dockPosition != null,
              trailingWidget: const Text('Dock Position'),
              actionWidget: DropdownButton<String>(
                onChanged: (value) => model.dockPosition = value,
                value: model.dockPosition,
                items: [
                  for (var item in AppearanceModel.dockPositions)
                    DropdownMenuItem(
                        child: Text(item.toLowerCase()), value: item)
                ],
              ),
            ),
            YaruRow(
              enabled: model.clickAction != null,
              description:
                  'Defines what happens when you click on active app icons.',
              trailingWidget: const Text('Click Action'),
              actionWidget: DropdownButton<String>(
                onChanged: (value) => model.clickAction = value,
                value: model.clickAction,
                items: [
                  for (var item in AppearanceModel.clickActions)
                    DropdownMenuItem(
                        child: Text(item.toLowerCase().replaceAll('-', ' ')),
                        value: item)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
