import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/power/suspend.dart';
import 'package:settings/view/pages/power/suspend_model.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SuspendSection extends StatefulWidget {
  const SuspendSection({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<SuspendModel>(
      create: (_) => SuspendModel(
        getService<SettingsService>(),
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
      width: kDefaultWidth,
      headline: Text(context.l10n.powerSuspendHeadline),
      children: <Widget>[
        YaruTile(
          enabled: model.powerButtonAction != null,
          title: Text(context.l10n.powerButtonBehavior),
          trailing: YaruPopupMenuButton<PowerButtonAction?>(
            initialValue: model.powerButtonAction,
            itemBuilder: (c) => PowerButtonAction.values.map((action) {
              return PopupMenuItem(
                value: action,
                child: Text(action.localize(context)),
                onTap: () => model.setPowerButtonAction(action),
              );
            }).toList(),
            child: Text(
              model.powerButtonAction != null
                  ? model.powerButtonAction!.localize(context)
                  : '',
            ),
          ),
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.batteryShowPercentage),
          value: model.showBatteryPercentage,
          onChanged: model.setShowBatteryPercentage,
        ),
      ],
    );
  }
}
