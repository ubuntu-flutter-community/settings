import 'package:flutter/material.dart';
import 'package:settings/view/duration_dropdown_button.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SuspendDelaySettingsRow extends StatelessWidget {
  const SuspendDelaySettingsRow({
    Key? key,
    required this.actionLabel,
    required this.suspend,
    required this.onSuspendChanged,
    required this.delay,
    required this.onDelayChanged,
  }) : super(key: key);

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
              const Text('Delay'),
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
