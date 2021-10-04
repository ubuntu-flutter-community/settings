import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class SwitchSettingsRow extends StatelessWidget {
  const SwitchSettingsRow({
    Key? key,
    required this.trailingWidget,
    this.actionDescription,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final Widget trailingWidget;
  final String? actionDescription;
  final bool? value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final value = this.value;

    if (value == null) {
      return const SizedBox();
    }

    return SettingsRow(
      trailingWidget: trailingWidget,
      description: actionDescription,
      actionWidget: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
