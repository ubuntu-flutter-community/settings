import 'package:flutter/material.dart';

class SliderSettingsSecondary extends StatelessWidget {
  const SliderSettingsSecondary({
    Key? key,
    required this.label,
    required this.enabled,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool? enabled;
  final double min;
  final double max;
  final double? value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    final enabled = this.enabled;
    final value = this.value;

    if (value == null || enabled == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: enabled
                ? null
                : TextStyle(color: Theme.of(context).disabledColor),
          ),
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: value,
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}
