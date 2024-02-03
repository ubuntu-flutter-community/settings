import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/duration_dropdown_button.dart';
import 'package:settings/view/common/section_description.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:settings/view/pages/privacy/screen_saver_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ScreenSaverPage extends StatelessWidget {
  const ScreenSaverPage({super.key});

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<ScreenSaverModel>(
        create: (_) => ScreenSaverModel(getService<SettingsService>()),
        child: const ScreenSaverPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ScreenSaverModel>();
    return SettingsPage(
      children: [
        SectionDescription(
          width: kDefaultWidth,
          text: context.l10n.screenSaverDescription,
        ),
        SettingsSection(
          width: kDefaultWidth,
          children: [
            YaruTile(
              enabled: model.idleDelay != null,
              title: Text(context.l10n.screenSaverTimerLabel),
              subtitle: Text(context.l10n.screenSaverTimerDescription),
              trailing: DurationDropdownButton(
                value: model.idleDelay,
                values: IdleDelay.values,
                onChanged: model.setIdleDelay,
              ),
            ),
            YaruSwitchRow(
              enabled: model.lockEnabled != null,
              trailingWidget: Text(context.l10n.screenSaverAutoScreenLockLabel),
              value: model.lockEnabled,
              onChanged: (v) => model.lockEnabled = v,
            ),
            YaruTile(
              enabled: model.lockDelay != null,
              title: Text(context.l10n.screenSaverAutoDelayLabel),
              subtitle: Text(context.l10n.screenSaverAutoDelayDescription),
              trailing: DurationDropdownButton(
                value: model.lockDelay,
                values: ScreenLockDelay.values,
                onChanged: (v) => model.lockDelay = v!.toInt(),
              ),
            ),
            YaruSwitchRow(
              enabled: model.ubuntuLockOnSuspend != null,
              trailingWidget:
                  Text(context.l10n.screenSaverLockScreenOnSuspendLabel),
              value: model.ubuntuLockOnSuspend,
              onChanged: (v) => model.ubuntuLockOnSuspend = v,
            ),
            YaruSwitchRow(
              enabled: model.showOnLockScreen != null,
              trailingWidget:
                  Text(context.l10n.screenSaverNotificationsOnLockScreen),
              value: model.showOnLockScreen,
              onChanged: (v) => model.showOnLockScreen = v,
            ),
          ],
        ),
      ],
    );
  }
}
