import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/common/selectable_svg_image.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_slider_row.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/appearance/dock_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DockSection extends StatelessWidget {
  const DockSection({super.key});
  static const assetHeight = 80.0;
  static const assetPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DockModel>();
    final unselectedColor = Theme.of(context).colorScheme.background;
    final selectedColor = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).primaryColor
        : lighten(Theme.of(context).primaryColor, 20);

    return SizedBox(
      width: kDefaultWidth,
      child: Column(
        children: [
          SettingsSection(
            headline: Text(context.l10n.dockAppearanceHeadline),
            children: [
              YaruTile(
                title: Text(context.l10n.dockPanelMode),
                subtitle: Text(
                  context.l10n.dockPanelModeDescription,
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
                  colorFilter: ColorFilter.mode(
                    (model.extendDock != null && model.extendDock == true)
                        ? selectedColor
                        : unselectedColor,
                    (model.extendDock != null && model.extendDock == true)
                        ? BlendMode.srcIn
                        : BlendMode.color,
                  ),
                  height: assetHeight,
                ),
              ),
              YaruTile(
                title: Text(context.l10n.dockDockMode),
                subtitle: Text(
                  context.l10n.dockDockModeDescription,
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
                  colorFilter: ColorFilter.mode(
                    (model.extendDock != null && !model.extendDock!)
                        ? selectedColor
                        : unselectedColor,
                    (model.extendDock != null && !model.extendDock!)
                        ? BlendMode.srcIn
                        : BlendMode.color,
                  ),
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
              ),
            ],
          ),
          SettingsSection(
            headline: Text(context.l10n.dockOptionsHeadline),
            children: [
              Column(
                children: [
                  YaruSwitchRow(
                    enabled: model.alwaysShowDock != null,
                    trailingWidget: Text(context.l10n.dockAutoHide),
                    actionDescription: context.l10n.dockAutoHideDescription,
                    value: model.alwaysShowDock != null &&
                        model.alwaysShowDock == false,
                    onChanged: (value) => model.alwaysShowDock = !value,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(assetPadding),
                    child: SvgPicture.asset(
                      model.getAutoHideAsset(),
                      colorFilter: ColorFilter.mode(
                        (model.alwaysShowDock != null && !model.alwaysShowDock!)
                            ? selectedColor
                            : unselectedColor,
                        (model.alwaysShowDock != null && !model.alwaysShowDock!)
                            ? BlendMode.srcIn
                            : BlendMode.color,
                      ),
                      height: assetHeight,
                    ),
                  ),
                ],
              ),
              YaruSwitchRow(
                trailingWidget: Text(context.l10n.dockShowTrash),
                actionDescription: context.l10n.dockShowTrashDescription,
                value: model.showTrash,
                onChanged: (value) => model.showTrash = value,
              ),
              YaruSwitchRow(
                trailingWidget: Text(context.l10n.dockIconGlow),
                actionDescription: context.l10n.dockIconGlowDescription,
                value: model.appGlow,
                onChanged: (value) => model.appGlow = value,
              ),
              YaruSliderRow(
                enabled: model.maxIconSize != null,
                actionLabel: context.l10n.dockIconSize,
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
