import 'package:flutter/material.dart';
import 'package:settings/utils.dart';

class DurationDropdownButton extends StatelessWidget {
  const DurationDropdownButton({
    Key? key,
    required this.value,
    required this.values,
    required this.onChanged,
    this.zeroValueText = 'Never',
  }) : super(key: key);

  /// The current value of the [DropdownButton]
  final int? value;

  /// The list of values for [DropdownMenuItem] elements
  final List<int> values;

  /// The callback that gets invoked when the [DropdownButton] value changes
  final ValueChanged<int?> onChanged;

  /// Optional string for value 0
  ///
  /// Defaults to 'Never'
  final String zeroValueText;

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
          DropdownMenuItem(
            value: 0,
            child: Text(zeroValueText),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
