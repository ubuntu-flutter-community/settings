import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/power/power_settings_model.dart';
import 'package:settings/view/pages/power/power_settings_widgets.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

Future<void> showAutomaticSuspendDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (_) => ChangeNotifierProvider.value(
      value: context.read<SuspendModel>(),
      child: const AutomaticSuspendDialog(),
    ),
  );
}

class AutomaticSuspendDialog extends StatelessWidget {
  const AutomaticSuspendDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuspendModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Automatic Suspend',
      closeIconData: YaruIcons.window_close,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SuspendDelaySettingsRow(
            actionLabel: 'On Battery Power',
            suspend: model.suspendOnBattery,
            onSuspendChanged: model.setSuspendOnBattery,
            delay: model.suspendOnBatteryDelay,
            onDelayChanged: model.setSuspendOnBatteryDelay,
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SuspendDelaySettingsRow(
            actionLabel: 'When Plugged In',
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
