import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class SliderSettingsRow extends StatelessWidget {
  const SliderSettingsRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final double? value;
  final double min;
  final double max;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    final value = this.value;

    if (value == null) {
      return const SizedBox();
    }

    return SettingsRow(
      actionLabel: actionLabel,
      actionDescription: actionDescription,
      secondChild: Expanded(
        child: Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
