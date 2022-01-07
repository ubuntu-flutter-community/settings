import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/appearance/appearance_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DockSection extends StatelessWidget {
  const DockSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppearanceModel>(context);

    return YaruSection(
      headline: 'Dock',
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Show Trash'),
          value: model.showTrash,
          onChanged: (value) => model.setShowTrash(value),
        ),
        Column(
          children: [
            YaruSwitchRow(
              trailingWidget: const Text('Auto-hide the Dock'),
              value: !model.alwaysShowDock,
              onChanged: (value) => model.setAlwaysShowDock(!value),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'assets/images/auto-hide.svg',
                color: !model.alwaysShowDock
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).backgroundColor,
                colorBlendMode: BlendMode.color,
                height: 80,
              ),
            )
          ],
        ),
        Column(
          children: [
            YaruSwitchRow(
              trailingWidget: const Text('Extend Dock'),
              value: model.extendDock,
              onChanged: (value) => model.setExtendDock(value),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/panel-mode.svg',
                color: model.extendDock
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).backgroundColor,
                colorBlendMode: BlendMode.color,
                height: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/dock-mode.svg',
                color: !model.extendDock
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).backgroundColor,
                colorBlendMode: BlendMode.color,
                height: 80,
              ),
            ),
          ],
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Active App Glow'),
          value: model.appGlow,
          onChanged: (value) => model.setAppGlow(value),
        ),
        YaruSliderRow(
          actionLabel: 'Icon Size',
          value: model.maxIconSize,
          min: 16,
          max: 64,
          defaultValue: 48,
          onChanged: (value) => model.setMaxIconSize(value),
        ),
        YaruRow(
          enabled: model.dockPosition != null,
          trailingWidget: const Text('Dock Position'),
          actionWidget: DropdownButton<String>(
            onChanged: (value) => model.dockPosition = value,
            value: model.dockPosition,
            items: [
              for (var item in AppearanceModel.dockPositions)
                DropdownMenuItem(child: Text(item.toLowerCase()), value: item)
            ],
          ),
        ),
        YaruRow(
          enabled: model.clickAction != null,
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
    );
  }
}
