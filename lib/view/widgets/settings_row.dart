import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class BoolSettingsRow extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final String schemaId;
  final String? path;

  const BoolSettingsRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.schemaId,
      this.path})
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
          value: _switchValue,
          onChanged: (bool newValue) {
            _settings.setValue(widget.settingsKey, newValue);

            setState(() {
              _switchValue = newValue;
            });
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

  const SliderRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.schemaId,
      this.min,
      this.max})
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

    double _speed = _settings.doubleValue(widget.settingsKey);
    return SettingsRow(
        actionLabel: widget.actionLabel,
        secondChild: Expanded(
          child: Slider(
            min: widget.min ?? 0.0,
            max: widget.max ?? 1.0,
            label: '$_speed',
            value: _speed,
            onChanged: (double newValue) {
              _settings.setValue('speed', newValue);
              setState(() {
                _speed = newValue;
              });
            },
          ),
        ));
  }
}

class DiscreteSlider extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final String schemaId;
  const DiscreteSlider(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.schemaId})
      : super(key: key);

  @override
  _DiscreteSliderState createState() => _DiscreteSliderState();
}

class _DiscreteSliderState extends State<DiscreteSlider> {
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
    int _dashMaxIconSize = _settings.intValue(widget.settingsKey);
    return SettingsRow(
        actionLabel: widget.actionLabel,
        secondChild: Expanded(
          child: Slider(
            label: '$_dashMaxIconSize',
            min: 16,
            max: 64,
            value: _dashMaxIconSize + .0,
            divisions: 24,
            onChanged: (double newValue) {
              _settings.setValue('dash-max-icon-size', newValue.round());
              setState(() {
                _dashMaxIconSize = newValue.round();
              });
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
