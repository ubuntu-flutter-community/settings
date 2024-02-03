import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/pages/power/lid_close_action.dart';
import 'package:settings/view/pages/power/lid_close_model.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class LidCloseSection extends StatelessWidget {
  const LidCloseSection({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LidCloseModel(getService<SettingsService>()),
      child: const LidCloseSection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LidCloseModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.lidCloseHeadline),
      children: [
        YaruTile(
          enabled: model.acLidCloseAction != null,
          title: Text(context.l10n.lidCloseActionOnAc),
          trailing: YaruPopupMenuButton<LidCloseAction?>(
            enabled: model.acLidCloseAction != null,
            initialValue: model.acLidCloseAction,
            itemBuilder: (c) => LidCloseAction.values.map((action) {
              return PopupMenuItem<LidCloseAction>(
                value: action,
                child: Text(action.localize(context.l10n)),
                onTap: () => model.acLidCloseAction = action,
              );
            }).toList(),
            child: Text(
              model.acLidCloseAction != null
                  ? model.acLidCloseAction!.localize(context.l10n)
                  : '',
            ),
          ),
        ),
        YaruTile(
          enabled: model.batteryLidCloseAction != null,
          title: Text(context.l10n.lidCloseActionOnBattery),
          trailing: YaruPopupMenuButton<LidCloseAction?>(
            enabled: model.batteryLidCloseAction != null,
            initialValue: model.batteryLidCloseAction,
            itemBuilder: (c) => LidCloseAction.values.map((action) {
              return PopupMenuItem<LidCloseAction>(
                value: action,
                child: Text(action.localize(context.l10n)),
                onTap: () => model.batteryLidCloseAction = action,
              );
            }).toList(),
            child: Text(
              model.batteryLidCloseAction != null
                  ? model.batteryLidCloseAction!.localize(context.l10n)
                  : '',
            ),
          ),
        ),
      ],
    );
  }
}
