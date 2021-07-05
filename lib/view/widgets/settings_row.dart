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
    return SettingsRow(
        actionLabel: widget.actionLabel,
        secondChild: Switch(
          value: _switchValue,
          onChanged: (bool newValue) {
            widget.settings.setValue(widget.settingsKey, newValue);

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
  final GSettings settings;
  const SliderRow(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.settings})
      : super(key: key);

  @override
  _SliderRowState createState() => _SliderRowState();
}

class _SliderRowState extends State<SliderRow> {
  @override
  Widget build(BuildContext context) {
    double _touchpadSpeed = widget.settings.doubleValue(widget.settingsKey);
    return SettingsRow(
        actionLabel: widget.actionLabel,
        secondChild: Expanded(
          child: Slider(
            label: '$_touchpadSpeed',
            value: _touchpadSpeed,
            onChanged: (double newValue) {
              widget.settings.setValue('speed', newValue);
              setState(() {
                _touchpadSpeed = newValue;
              });
            },
          ),
        ));
  }
}

class DiscreteSlider extends StatefulWidget {
  final String actionLabel;
  final String settingsKey;
  final GSettings settings;
  const DiscreteSlider(
      {Key? key,
      required this.actionLabel,
      required this.settingsKey,
      required this.settings})
      : super(key: key);

  @override
  _DiscreteSliderState createState() => _DiscreteSliderState();
}

class _DiscreteSliderState extends State<DiscreteSlider> {
  @override
  Widget build(BuildContext context) {
    int _dashMaxIconSize = widget.settings.intValue(widget.settingsKey);
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
              widget.settings.setValue('dash-max-icon-size', newValue.round());
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
