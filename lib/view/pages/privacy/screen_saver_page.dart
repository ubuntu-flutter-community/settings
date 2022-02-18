import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:settings/view/pages/power/power_settings_widgets.dart';
import 'package:settings/view/pages/privacy/screen_saver_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ScreenSaverPage extends StatelessWidget {
  const ScreenSaverPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<ScreenSaverModel>(
        create: (_) => ScreenSaverModel(context.read<SettingsService>()),
        child: const ScreenSaverPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ScreenSaverModel>();
    return YaruPage(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: kDefaultWidth,
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  context.l10n.screenSaverDescription,
                  style: Theme.of(context).textTheme.caption,
                )),
              ],
            ),
          ),
        ),
        YaruSection(width: kDefaultWidth, children: [
          YaruRow(
            width: kDefaultWidth,
            enabled: model.idleDelay != null,
            trailingWidget: Text(context.l10n.screenSaverTimerLabel),
            description: context.l10n.screenSaverTimerDescription,
            actionWidget: DurationDropdownButton(
              value: model.idleDelay,
              values: IdleDelay.values,
              onChanged: model.setIdleDelay,
            ),
          ),
          YaruSwitchRow(
              enabled: model.lockEnabled != null,
              width: kDefaultWidth,
              trailingWidget: Text(context.l10n.screenSaverAutoScreenLockLabel),
              value: model.lockEnabled,
              onChanged: (v) => model.lockEnabled = v),
          YaruSliderRow(
              enabled: model.lockDelay != null,
              width: kDefaultWidth,
              actionLabel: context.l10n.screenSaverTimerLabel,
              actionDescription: context.l10n.screenSaverTimerDescription,
              value: model.lockDelay?.toDouble(),
              min: 0,
              max: 3600,
              onChanged: (v) => model.lockDelay = v.toInt()),
          YaruSwitchRow(
              enabled: model.ubuntuLockOnSuspend != null,
              width: kDefaultWidth,
              trailingWidget:
                  Text(context.l10n.screenSaverLockScreenOnSuspendLabel),
              value: model.ubuntuLockOnSuspend,
              onChanged: (v) => model.ubuntuLockOnSuspend = v),
          YaruSwitchRow(
              enabled: model.showOnLockScreen != null,
              width: kDefaultWidth,
              trailingWidget:
                  Text(context.l10n.screenSaverNotificationsOnLockScreen),
              value: model.showOnLockScreen,
              onChanged: (v) => model.showOnLockScreen = v),
        ])
      ],
    );
  }
}
