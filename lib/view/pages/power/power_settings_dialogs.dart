import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/duration_dropdown_button.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:settings/view/pages/power/power_settings_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';

Future<void> showAutomaticSuspendDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (_) => ChangeNotifierProvider.value(
      value: getService<SuspendModel>(),
      child: const AutomaticSuspendDialog(),
    ),
  );
}

class AutomaticSuspendDialog extends StatelessWidget {
  const AutomaticSuspendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuspendModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.powerAutomaticSuspend,
      closeIconData: YaruIcons.window_close,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: _SuspendDelaySettingsRow(
            actionLabel: context.l10n.powerOnBattery,
            suspend: model.suspendOnBattery,
            onSuspendChanged: model.setSuspendOnBattery,
            delay: model.suspendOnBatteryDelay,
            onDelayChanged: model.setSuspendOnBatteryDelay,
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: _SuspendDelaySettingsRow(
            actionLabel: context.l10n.powerWhenPluggedIn,
            suspend: model.suspendWhenPluggedIn,
            onSuspendChanged: model.setSuspendWhenPluggedIn,
            delay: model.suspendWhenPluggedInDelay,
            onDelayChanged: model.setSuspendWhenPluggedInDelay,
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _SuspendDelaySettingsRow extends StatelessWidget {
  const _SuspendDelaySettingsRow({
    required this.actionLabel,
    required this.suspend,
    required this.onSuspendChanged,
    required this.delay,
    required this.onDelayChanged,
  });

  final String actionLabel;
  final bool? suspend;
  final int? delay;
  final ValueChanged<bool> onSuspendChanged;
  final ValueChanged<int?> onDelayChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          YaruSwitchRow(
            trailingWidget: Text(actionLabel),
            value: suspend,
            onChanged: onSuspendChanged,
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              Text(context.l10n.powerSuspendDelay),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DurationDropdownButton(
                  value: delay,
                  values: SuspendDelay.values,
                  onChanged: onDelayChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
