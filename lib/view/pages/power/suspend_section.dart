import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/suspend.dart';
import 'package:settings/view/pages/power/suspend_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SuspendSection extends StatefulWidget {
  const SuspendSection({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<SuspendModel>(
      create: (_) => SuspendModel(
        context.read<SettingsService>(),
      ),
      child: const SuspendSection(),
    );
  }

  @override
  State<SuspendSection> createState() => _SuspendSectionState();
}

class _SuspendSectionState extends State<SuspendSection> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuspendModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: 'Suspend & Power Button',
      children: <Widget>[
        YaruRow(
          enabled: model.powerButtonAction != null,
          trailingWidget: const Text('Power Button Behavior'),
          actionWidget: DropdownButton<PowerButtonAction?>(
            value: model.powerButtonAction,
            items: PowerButtonAction.values.map((action) {
              return DropdownMenuItem(
                value: action,
                child: Text(action.localize(context)),
              );
            }).toList(),
            onChanged: model.setPowerButtonAction,
          ),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Show Battery Percentage'),
          value: model.showBatteryPercentage,
          onChanged: model.setShowBatteryPercentage,
        ),
      ],
    );
  }
}
