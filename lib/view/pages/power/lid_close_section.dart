import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/lid_close_action.dart';
import 'package:settings/view/pages/power/lid_close_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class LidCloseSection extends StatelessWidget {
  const LidCloseSection({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LidCloseModel(context.read<SettingsService>()),
      child: const LidCloseSection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LidCloseModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: 'Lid Close',
      children: [
        YaruTile(
          enabled: model.acLidCloseAction != null,
          title: const Text('Lid Close Action on Ac'),
          trailing: DropdownButton<LidCloseAction?>(
            value: model.acLidCloseAction,
            items: LidCloseAction.values.map((action) {
              return DropdownMenuItem<LidCloseAction>(
                value: action,
                child: Text(action.localize(context)),
              );
            }).toList(),
            onChanged: (value) => model.acLidCloseAction = value,
          ),
        ),
        YaruTile(
          enabled: model.batteryLidCloseAction != null,
          title: const Text('Lid Close Action on Battery'),
          trailing: DropdownButton<LidCloseAction?>(
            value: model.batteryLidCloseAction,
            items: LidCloseAction.values.map((action) {
              return DropdownMenuItem<LidCloseAction>(
                value: action,
                child: Text(action.localize(context)),
              );
            }).toList(),
            onChanged: (value) => model.batteryLidCloseAction = value,
          ),
        )
      ],
    );
  }
}
