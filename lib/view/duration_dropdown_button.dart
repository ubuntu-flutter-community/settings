import 'package:flutter/material.dart';
import 'package:settings/utils.dart';

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
