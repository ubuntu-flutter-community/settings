import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';

class ToggleButtonsSettingRow extends StatelessWidget {
  const ToggleButtonsSettingRow({
    Key? key,
    required this.actionLabel,
    required this.currentValue,
    required this.labels,
    required this.onPressed,
  }) : super(key: key);

  final String actionLabel;
  final List<bool>? currentValue;
  final List<String> labels;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final _currentValue = currentValue;

    if (_currentValue == null) {
      return const SizedBox();
    }

    return SettingsRow(
      actionLabel: actionLabel,
      secondChild: ToggleButtons(
        constraints: const BoxConstraints(minHeight: 40.0),
        isSelected: _currentValue,
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
