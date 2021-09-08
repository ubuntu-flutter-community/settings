import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class SwitchSettingsRow extends StatelessWidget {
  const SwitchSettingsRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      actionLabel: actionLabel,
      actionDescription: actionDescription,
      secondChild: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
