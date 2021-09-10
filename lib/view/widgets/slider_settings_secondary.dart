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
    final _enabled = enabled;
    final _value = value;

    if (_value == null || _enabled == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: _enabled
                ? null
                : TextStyle(color: Theme.of(context).disabledColor),
          ),
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: _value,
            onChanged: _enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}
