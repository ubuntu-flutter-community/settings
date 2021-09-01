import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class SwitchSettingsRow extends StatelessWidget {
  const SwitchSettingsRow({
    Key? key,
    required this.actionLabel,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String actionLabel;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      actionLabel: actionLabel,
      secondChild: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
