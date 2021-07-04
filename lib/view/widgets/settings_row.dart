import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class BoolSettingsRow extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final GSettings settings;

  const BoolSettingsRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.settings})
      : super(key: key);

  @override
  State<BoolSettingsRow> createState() => _BoolSettingsRowState();
}

class _BoolSettingsRowState extends State<BoolSettingsRow> {
  @override
  Widget build(BuildContext context) {
    bool _switchValue = widget.settings.boolValue(widget.settingsKey);
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.actionLabel),
            Switch(
              value: _switchValue,
              onChanged: (bool newValue) {
                widget.settings.setValue(widget.settingsKey, newValue);

                setState(() {
                  _switchValue = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
