import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

import 'settings_row.dart';

class SingleGsettingRow extends StatefulWidget {
  const SingleGsettingRow({
    Key? key,
    required this.actionLabel,
    required this.settingsKey,
    required this.schemaId,
    this.path,
    this.invertedValue = false,
  }) : super(key: key);

  final String actionLabel;
  final String settingsKey;
  final String schemaId;
  final String? path;
  final bool invertedValue;

  @override
  State<SingleGsettingRow> createState() => _SingleGsettingRowState();
}

class _SingleGsettingRowState extends State<SingleGsettingRow> {
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
          secondChild: Text(widget.schemaId));
    }

    _settings = GSettings(schemaId: widget.schemaId, path: widget.path);
    bool _switchValue = _settings.boolValue(widget.settingsKey);

    return SettingsRow(
      actionLabel: widget.actionLabel,
      secondChild: Switch(
        value: widget.invertedValue ? !_switchValue : _switchValue,
        onChanged: (bool newValue) {
          _settings.setValue(
            widget.settingsKey,
            widget.invertedValue ? !newValue : newValue,
          );
          setState(() {});
        },
      ),
    );
  }
}
