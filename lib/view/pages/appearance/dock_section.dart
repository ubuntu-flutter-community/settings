import 'package:flutter/material.dart';
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
        YaruSwitchRow(
          trailingWidget: const Text('Always Show Dock'),
          value: model.alwaysShowDock,
          onChanged: (value) => model.setAlwaysShowDock(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Extend Dock'),
          value: model.extendDock,
          onChanged: (value) => model.setExtendDock(value),
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
