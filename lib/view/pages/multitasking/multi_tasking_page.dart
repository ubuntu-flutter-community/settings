import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/multitasking/multi_tasking_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MultiTaskingPage extends StatelessWidget {
  const MultiTaskingPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<MultiTaskingModel>(
      create: (_) => MultiTaskingModel(getService<SettingsService>()),
      child: const MultiTaskingPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.multiTaskingPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.multiTaskingPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MultiTaskingModel>();
    final unselectedColor = Theme.of(context).colorScheme.background;
    final selectedColor = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).primaryColor
        : lighten(Theme.of(context).primaryColor, 20);

    return SettingsPage(
      children: [
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('General'),
          children: [
            Column(
              children: [
                YaruSwitchRow(
                  actionDescription:
                      'Touch the top-left corner to open the Activities Overview.',
                  trailingWidget: const Text('Hot corner'),
                  value: model.enableHotCorners,
                  onChanged: (value) => model.enableHotCorners = value,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    model.getHotCornerAsset(),
                    colorFilter: ColorFilter.mode(
                      (model.enableHotCorners != null &&
                              model.enableHotCorners == true)
                          ? selectedColor
                          : unselectedColor,
                      (model.enableHotCorners != null &&
                              model.enableHotCorners == true)
                          ? BlendMode.srcIn
                          : BlendMode.color,
                    ),
                    height: 80,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                YaruSwitchRow(
                  actionDescription:
                      'Drag windows against top, left and right screen edges to resize them',
                  trailingWidget: const Text('Enable active edge tiling'),
                  value: model.edgeTiling,
                  onChanged: (value) => model.edgeTiling = value,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    model.getActiveEdgesAsset(),
                    colorFilter: ColorFilter.mode(
                      model.edgeTiling != null && model.edgeTiling == true
                          ? selectedColor
                          : unselectedColor,
                      model.edgeTiling != null && model.edgeTiling == true
                          ? BlendMode.srcIn
                          : BlendMode.color,
                    ),
                    height: 80,
                  ),
                ),
              ],
            ),
          ],
        ),
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Workspaces'),
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('Dynamic Workspaces'),
              leading: YaruRadio<bool>(
                value: true,
                groupValue: model.dynamicWorkspaces,
                onChanged: (value) => model.dynamicWorkspaces = value,
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('Fixed number of workspaces'),
              leading: YaruRadio<bool>(
                value: false,
                groupValue: model.dynamicWorkspaces,
                onChanged: (value) => model.dynamicWorkspaces = value!,
              ),
            ),
            YaruTile(
              enabled: model.dynamicWorkspaces != null &&
                  model.dynamicWorkspaces == false,
              title: const Text('Number of workspaces'),
              trailing: SizedBox(
                height: 40,
                width: 150,
                child: SpinBox(
                  min: 1,
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  enabled: model.dynamicWorkspaces != null &&
                      model.dynamicWorkspaces == false,
                  value: model.numWorkspaces != null
                      ? model.numWorkspaces!.toDouble()
                      : 0,
                  onChanged: (value) => model.numWorkspaces = value.toInt(),
                ),
              ),
            ),
          ],
        ),
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Multi-Monitor'),
          children: [
            YaruTile(
              title: const Text('Workspaces span all displays'),
              subtitle: const Text(
                'All displays are included in one workspace and follow when you switch workspaces.',
              ),
              trailing: YaruRadio(
                value: false,
                groupValue: model.workSpaceOnlyOnPrimary,
                onChanged: (value) => model.workSpaceOnlyOnPrimary = value,
              ),
              enabled: model.workSpaceOnlyOnPrimary != null,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                model.getWorkspacesSpanDisplayAsset(),
                colorFilter: ColorFilter.mode(
                  !(model.workSpaceOnlyOnPrimary != null &&
                          model.workSpaceOnlyOnPrimary == true)
                      ? selectedColor
                      : unselectedColor,
                  !(model.workSpaceOnlyOnPrimary != null &&
                          model.workSpaceOnlyOnPrimary == true)
                      ? BlendMode.srcIn
                      : BlendMode.color,
                ),
                height: 60,
              ),
            ),
            YaruTile(
              title: const Text('Workspaces only on primary display'),
              subtitle: const Text(
                'Only your primary display is included in workspace switching.',
              ),
              trailing: YaruRadio(
                value: true,
                groupValue: model.workSpaceOnlyOnPrimary,
                onChanged: (value) => model.workSpaceOnlyOnPrimary = value,
              ),
              enabled: model.workSpaceOnlyOnPrimary != null,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                model.getWorkspacesPrimaryDisplayAsset(),
                colorFilter: ColorFilter.mode(
                  !(model.workSpaceOnlyOnPrimary != null &&
                          model.workSpaceOnlyOnPrimary == false)
                      ? selectedColor
                      : unselectedColor,
                  !(model.workSpaceOnlyOnPrimary != null &&
                          model.workSpaceOnlyOnPrimary == false)
                      ? BlendMode.srcIn
                      : BlendMode.color,
                ),
                height: 60,
              ),
            ),
          ],
        ),
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Application Switching'),
          children: [
            YaruSwitchRow(
              trailingWidget:
                  const Text('Show applications from current workspace only'),
              value: model.currentWorkspaceOnly,
              onChanged: (value) => model.currentWorkspaceOnly = value,
            ),
          ],
        ),
      ],
    );
  }
}
