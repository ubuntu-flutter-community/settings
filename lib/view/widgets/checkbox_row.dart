import 'package:flutter/material.dart';

class CheckboxRow extends StatelessWidget {
  const CheckboxRow({
    Key? key,
    required this.enabled,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final bool? enabled;
  final bool? value;
  final Function(bool?) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    final _enabled = enabled;
    final _value = value;

    if (_enabled == null || _value == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: _enabled ? onChanged : null,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: _enabled
                ? null
                : TextStyle(color: Theme.of(context).disabledColor),
          ),
        ),
      ],
    );
  }
}
