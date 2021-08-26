import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_row.dart';

class ToggleButtonsGsettingRow extends StatefulWidget {
  const ToggleButtonsGsettingRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.settingsKey,
    required this.schemaId,
    required this.settingsValues,
    required this.buttonLabels,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final String settingsKey;
  final String schemaId;

  /// List of available values for this setting.
  final List<String> settingsValues;

  /// List of labels for buttons.
  /// Must correspond to the values in [settingsValues]
  final List<String> buttonLabels;

  @override
  _ToggleButtonsGsettingRowState createState() =>
      _ToggleButtonsGsettingRowState();
}

class _ToggleButtonsGsettingRowState extends State<ToggleButtonsGsettingRow> {
  late GSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = GSettings(schemaId: widget.schemaId);
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GSettingsSchema.lookup(widget.schemaId) == null) {
      return SettingsRow(
        actionLabel: 'Schema not installed:',
        secondChild: Text(widget.schemaId),
      );
    }

    final _currentValue = _settings.stringValue(widget.settingsKey);
    final _availableValues = widget.settingsValues
        .map((value) => _currentValue.contains(value))
        .toList();

    return SettingsRow(
      actionLabel: widget.actionLabel,
      secondChild: ToggleButtons(
        constraints: const BoxConstraints(minHeight: 40.0),
        isSelected: _availableValues,
        children: widget.buttonLabels
            .map(
              (label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(label),
              ),
            )
            .toList(),
        onPressed: (index) {
          setState(
            () => _settings.setValue(
              widget.settingsKey,
              widget.settingsValues[index],
            ),
          );
        },
      ),
    );
  }
}
