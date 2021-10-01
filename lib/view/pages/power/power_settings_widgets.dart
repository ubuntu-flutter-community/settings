import 'package:flutter/material.dart';
import 'package:settings/view/pages/power/power_settings.dart';
import 'package:settings/view/pages/power/power_utils.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class DurationDropdownButton extends StatelessWidget {
  const DurationDropdownButton({
    Key? key,
    required this.value,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  final int? value;
  final List<int> values;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      items: [
        for (final value in values.where((value) => value > 0))
          DropdownMenuItem(
            value: value,
            child: Text(formatTime(value)),
          ),
        if (values.contains(0))
          const DropdownMenuItem(
            value: 0,
            child: Text('Never'),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SwitchSettingsRow(
          actionLabel: actionLabel,
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
    );
  }
}
