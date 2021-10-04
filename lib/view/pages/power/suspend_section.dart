import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/suspend.dart';
import 'package:settings/view/pages/power/suspend_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

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
    return SettingsSection(
      headline: 'Suspend & Power Button',
      children: <Widget>[
        SettingsRow(
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
        SwitchSettingsRow(
          actionLabel: 'Show Battery Percentage',
          value: model.showBatteryPercentage,
          onChanged: model.setShowBatteryPercentage,
        ),
      ],
    );
  }
}
