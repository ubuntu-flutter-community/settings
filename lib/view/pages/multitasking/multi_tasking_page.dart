import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/multitasking/multi_tasking_model.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MultiTaskingPage extends StatelessWidget {
  const MultiTaskingPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<MultiTaskingModel>(
      create: (_) => MultiTaskingModel(service),
      child: const MultiTaskingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MultiTaskingModel>();
    return Column(
      children: [
        YaruSection(headline: 'General', children: [
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
                  'assets/images/hot-corner.svg',
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
                  'assets/images/active-screen-edges.svg',
                  height: 80,
                ),
              ),
            ],
          )
        ]),
        YaruSection(headline: 'Workspaces', children: [
          RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Dynamic Workspaces'),
            value: true,
            groupValue: model.dynamicWorkspaces,
            onChanged: (bool? value) => model.dynamicWorkspaces = value!,
          ),
          RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Fixed number of workspaces'),
            value: false,
            groupValue: model.dynamicWorkspaces,
            onChanged: (bool? value) => model.dynamicWorkspaces = value!,
          ),
          YaruRow(
              trailingWidget: Text(
                'Number of workspaces',
                style: model.dynamicWorkspaces
                    ? TextStyle(color: Theme.of(context).disabledColor)
                    : null,
              ),
              actionWidget: SizedBox(
                height: 40,
                width: 150,
                child: SpinBox(
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  enabled: !model.dynamicWorkspaces,
                  value: model.numWorkspaces.toDouble(),
                  onChanged: (value) => model.numWorkspaces = value.toInt(),
                ),
              ))
        ]),
        YaruSection(headline: 'Multi-Monitor', children: [
          YaruSwitchRow(
            trailingWidget: const Text('Workspaces on primary display only'),
            value: model.workSpaceOnlyOnPrimary,
            onChanged: (value) => model.workSpaceOnlyOnPrimary = value,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/images/workspaces-primary-display.svg',
              color: model.workSpaceOnlyOnPrimary
                  ? null
                  : Theme.of(context).disabledColor.withOpacity(0.5),
              colorBlendMode: Theme.of(context).brightness == Brightness.dark
                  ? BlendMode.hardLight
                  : BlendMode.darken,
              height: 60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/images/workspaces-span-displays.svg',
              color: !model.workSpaceOnlyOnPrimary
                  ? null
                  : Theme.of(context).disabledColor.withOpacity(0.5),
              colorBlendMode: Theme.of(context).brightness == Brightness.dark
                  ? BlendMode.hardLight
                  : BlendMode.darken,
              height: 60,
            ),
          )
        ]),
        YaruSection(
          headline: 'Application Switching',
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
