import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class BoolSettingsRow extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final String schemaId;
  final String? path;
  final bool invertedValue;

  const BoolSettingsRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.schemaId,
      this.path,
      this.invertedValue = false})
      : super(key: key);

  @override
  State<BoolSettingsRow> createState() => _BoolSettingsRowState();
}

class _BoolSettingsRowState extends State<BoolSettingsRow> {
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
            _settings.setValue(widget.settingsKey,
                widget.invertedValue ? !newValue : newValue);

            setState(() {});
          },
        ));
  }
}

class SliderRow extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final String schemaId;
  final double? min;
  final double? max;
  final int? divisions;
  final bool discrete;

  const SliderRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.schemaId,
      this.min,
      this.max,
      this.divisions,
      required this.discrete})
      : super(key: key);

  @override
  _SliderRowState createState() => _SliderRowState();
}

class _SliderRowState extends State<SliderRow> {
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

    _settings = GSettings(schemaId: widget.schemaId);

    final _value = widget.discrete
        ? _settings.intValue(widget.settingsKey) + .0
        : _settings.doubleValue(widget.settingsKey);

    return SettingsRow(
        actionLabel: widget.actionLabel,
        secondChild: Expanded(
          child: Slider(
            label: widget.discrete ? '$_value'.replaceAll('.0', '') : '$_value',
            min: widget.min ?? 0.0,
            max: widget.max ?? 1.0,
            divisions: widget.divisions,
            value: _value,
            onChanged: (double newValue) {
              _settings.setValue(widget.settingsKey,
                  widget.discrete ? newValue.round() : newValue);
              setState(() {});
            },
          ),
        ));
  }
}

class SettingsRow extends StatelessWidget {
  final String actionLabel;
  final Widget secondChild;

  const SettingsRow(
      {Key? key, required this.actionLabel, required this.secondChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                actionLabel,
              ),
            ),
            secondChild,
          ],
        ),
      ),
    );
  }
}
