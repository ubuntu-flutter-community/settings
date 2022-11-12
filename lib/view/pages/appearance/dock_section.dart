import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/pages/appearance/dock_model.dart';
import 'package:settings/view/selectable_svg_image.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DockSection extends StatelessWidget {
  const DockSection({Key? key}) : super(key: key);
  static const assetHeight = 80.0;
  static const assetPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DockModel>();
    final unselectedColor = Theme.of(context).backgroundColor;
    final selectedColor = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).primaryColor
        : lighten(Theme.of(context).primaryColor, 20);

    return SizedBox(
      width: kDefaultWidth,
      child: Column(
        children: [
          SettingsSection(
            headline: const Text('Dock appearance'),
            children: [
              YaruTile(
                title: const Text('Panel mode'),
                subtitle: const Text(
                  'Extends the height of the dock to become a panel.',
                ),
                trailing: YaruRadio<bool>(
                  value: true,
                  groupValue: model.extendDock,
                  onChanged: (value) => model.extendDock = value,
                ),
                enabled: model.extendDock != null,
              ),
              Padding(
                padding: const EdgeInsets.all(assetPadding),
                child: SvgPicture.asset(
                  model.getPanelModeAsset(),
                  color: (model.extendDock != null && model.extendDock == true)
                      ? selectedColor
                      : unselectedColor,
                  colorBlendMode:
                      (model.extendDock != null && model.extendDock == true)
                          ? BlendMode.srcIn
                          : BlendMode.color,
                  height: assetHeight,
                ),
              ),
              YaruTile(
                title: const Text('Dock mode'),
                subtitle: const Text(
                  'Displays the dock in a centered, free-floating mode.',
                ),
                trailing: YaruRadio<bool>(
                  value: false,
                  groupValue: model.extendDock,
                  onChanged: (value) => model.extendDock = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(assetPadding),
                child: SvgPicture.asset(
                  model.getDockModeAsset(),
                  color: (model.extendDock != null && !model.extendDock!)
                      ? selectedColor
                      : unselectedColor,
                  colorBlendMode:
                      (model.extendDock != null && !model.extendDock!)
                          ? BlendMode.srcIn
                          : BlendMode.color,
                  height: assetHeight,
                ),
              ),
            ],
          ),
          SettingsSection(
            headline: Text(context.l10n.dockPosition),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(DockPosition.left.localize(context.l10n)),
                        ),
                        SizedBox(
                          child: SelectableSvgImage(
                            selectedColor: selectedColor,
                            padding: 8.0,
                            path: model.getLeftSideAsset(),
                            selected: model.dockPosition == DockPosition.left,
                            height: assetHeight,
                            onTap: () => model.dockPosition = DockPosition.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(DockPosition.right.localize(context.l10n)),
                        ),
                        SelectableSvgImage(
                          selectedColor: selectedColor,
                          padding: 8.0,
                          path: model.getRightSideAsset(),
                          selected: model.dockPosition == DockPosition.right,
                          height: assetHeight,
                          onTap: () => model.dockPosition = DockPosition.right,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(DockPosition.bottom.localize(context.l10n)),
                        ),
                        SelectableSvgImage(
                          selectedColor: selectedColor,
                          padding: 8.0,
                          path: model.getBottomAsset(),
                          selected: model.dockPosition == DockPosition.bottom,
                          height: assetHeight,
                          onTap: () => model.dockPosition = DockPosition.bottom,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SettingsSection(
            headline: const Text('Dock options'),
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
                      model.getAutoHideAsset(),
                      color: (model.alwaysShowDock != null &&
                              !model.alwaysShowDock!)
                          ? selectedColor
                          : unselectedColor,
                      colorBlendMode: (model.alwaysShowDock != null &&
                              !model.alwaysShowDock!)
                          ? BlendMode.srcIn
                          : BlendMode.color,
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
                enabled: model.maxIconSize != null,
                actionLabel: 'Icon Size',
                value: model.maxIconSize ?? 48.0,
                min: 16,
                max: 64,
                defaultValue: 48,
                onChanged: (value) => model.maxIconSize = value,
              ),
              YaruTile(
                enabled: model.clickAction != null,
                title: Text(
                  context.l10n.dockClickAction,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: YaruPopupMenuButton<DockClickAction?>(
                  enabled: model.clickAction != null,
                  initialValue: model.clickAction,
                  itemBuilder: (context) => DockClickAction.values
                      .map(
                        (e) => PopupMenuItem<DockClickAction?>(
                          onTap: () => model.clickAction = e,
                          child: Text(
                            e.localize(context.l10n),
                          ),
                        ),
                      )
                      .toList(),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 200),
                    child: Text(
                      model.clickAction != null
                          ? model.clickAction!.localize(context.l10n)
                          : '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
