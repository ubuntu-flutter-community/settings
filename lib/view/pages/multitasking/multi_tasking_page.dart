import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/multitasking/multi_tasking_model.dart';
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
          YaruSwitchRow(
            trailingWidget: const Text('Enable hot corners'),
            value: model.enableHotCorners,
            onChanged: (value) => model.enableHotCorners = value,
          ),
          YaruSwitchRow(
            trailingWidget: const Text('Enable active edge tiling'),
            value: model.edgeTiling,
            onChanged: (value) => model.edgeTiling = value,
          )
        ]),
        YaruSection(headline: 'Workspaces', children: [
          YaruSwitchRow(
            trailingWidget: const Text('Dynamic workspaces'),
            value: model.dynamicWorkspaces,
            onChanged: (value) => model.dynamicWorkspaces = value,
          )
        ])
      ],
    );
  }
}
