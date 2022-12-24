import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/duration_dropdown_button.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:settings/view/pages/power/power_settings_dialogs.dart';
import 'package:settings/view/pages/power/power_settings_model.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PowerSettingsSection extends StatefulWidget {
  const PowerSettingsSection({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<SuspendModel>(
      create: (_) => SuspendModel(
        settings: context.read<SettingsService>(),
        power: context.read<PowerSettingsService>(),
        bluetooth: context.read<BluetoothService>(),
        network: context.read<NetworkManagerClient>(),
      ),
      child: const PowerSettingsSection(),
    );
  }

  @override
  State<PowerSettingsSection> createState() => _PowerSettingsSectionState();
}

class _PowerSettingsSectionState extends State<PowerSettingsSection> {
  @override
  void initState() {
    super.initState();
    context.read<SuspendModel>().init();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuspendModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.powerSaving),
      children: <Widget>[
        YaruSliderRow(
          enabled:
              model.screenBrightness != null && model.screenBrightness != -1,
          actionLabel: context.l10n.powerScreenBrightness,
          min: model.screenBrightness != -1 ? 0 : -1,
          max: 100,
          value: model.screenBrightness != -1 ? model.screenBrightness : 0,
          onChanged: model.setScreenBrightness,
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.powerAutomaticBrightness),
          value: model.ambientEnabled,
          onChanged: model.setAmbientEnabled,
        ),
        YaruSliderRow(
          enabled: model.keyboardBrightness != null &&
              model.keyboardBrightness != -1,
          actionLabel: context.l10n.powerKeyboardBrightness,
          min: model.keyboardBrightness != -1 ? 0 : -1,
          max: 100,
          value: model.keyboardBrightness != -1 ? model.keyboardBrightness : 0,
          onChanged: model.setKeyboardBrightness,
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.powerDimScreenWhenInactive),
          value: model.idleDim,
          onChanged: model.setIdleDim,
        ),
        YaruTile(
          enabled: model.idleDelay != null,
          title: Text(context.l10n.powerBlankScreen),
          trailing: DurationDropdownButton(
            value: model.idleDelay,
            values: IdleDelay.values,
            onChanged: model.setIdleDelay,
          ),
        ),
        YaruTile(
          title: Text(context.l10n.powerAutomaticSuspend),
          subtitle: Text(model.automaticSuspend.localize(context)),
          trailing: SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () => showAutomaticSuspendDialog(context),
              child: const Icon(YaruIcons.settings),
            ),
          ),
        ),
        if (model.hasWifi)
          YaruSwitchRow(
            trailingWidget: Text(context.l10n.powerWifiTitle),
            actionDescription: context.l10n.powerWifiDescription,
            value: model.wifiEnabled,
            onChanged: model.setWifiEnabled,
          ),
        if (model.hasBluetooth)
          YaruSwitchRow(
            trailingWidget: Text(context.l10n.powerBluetoothTitle),
            actionDescription: context.l10n.powerBluetoothDescription,
            value: model.bluetoothEnabled,
            onChanged: model.setBluetoothEnabled,
          ),
      ],
    );
  }
}
