import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class ToggleButtonsSettingRow extends StatelessWidget {
  const ToggleButtonsSettingRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.labels,
    required this.selectedValues,
    required this.onPressed,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final List<String> labels;
  final List<bool>? selectedValues;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final _selectedValues = selectedValues;

    if (_selectedValues == null) {
      return const SizedBox();
    }

    return SettingsRow(
      actionLabel: actionLabel,
      actionDescription: actionDescription,
      secondChild: ToggleButtons(
        constraints: const BoxConstraints(minHeight: 40.0),
        isSelected: _selectedValues,
        children: labels
            .map(
              (label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(label),
              ),
            )
            .toList(),
        onPressed: onPressed,
      ),
    );
  }
}
