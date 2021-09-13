import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

import 'settings_row.dart';

class SliderGsettingRow extends StatefulWidget {
  const SliderGsettingRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.settingsKey,
    required this.schemaId,
    this.min,
    this.max,
    this.divisions,
    required this.discrete,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final String settingsKey;
  final String schemaId;
  final double? min;
  final double? max;
  final int? divisions;
  final bool discrete;

  @override
  _SliderGsettingRowState createState() => _SliderGsettingRowState();
}

class _SliderGsettingRowState extends State<SliderGsettingRow> {
  late GSettings _settings;

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

    _settings = GSettings(schemaId: widget.schemaId);

    final _value = widget.discrete
        ? _settings.intValue(widget.settingsKey) + .0
        : _settings.doubleValue(widget.settingsKey);

    return SettingsRow(
      actionLabel: widget.actionLabel,
      actionDescription: widget.actionDescription,
      secondChild: Expanded(
        child: Slider(
          label: widget.discrete ? '$_value'.replaceAll('.0', '') : '$_value',
          min: widget.min ?? 0.0,
          max: widget.max ?? 1.0,
          divisions: widget.divisions,
          value: _value,
          onChanged: (double newValue) {
            _settings.setValue(
              widget.settingsKey,
              widget.discrete ? newValue.round() : newValue,
            );
            setState(() {});
          },
        ),
      ),
    );
  }
}
