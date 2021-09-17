import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/slider_value_marker.dart';

class SliderSettingsRow extends StatelessWidget {
  const SliderSettingsRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    this.defaultValue,
    required this.min,
    required this.max,
    this.showValue = true,
    this.fractionDigits = 0,
    required this.onChanged,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final double? value;
  final double? defaultValue;
  final double min;
  final double max;
  final bool showValue;
  final int fractionDigits;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    const thumbRadius = 24.0;
    final value = this.value;

    if (value == null) {
      return const SizedBox();
    }

    return SettingsRow(
      actionLabel: actionLabel,
      actionDescription: actionDescription,
      secondChild: Expanded(
        flex: 2,
        child: Row(
          children: [
            if (showValue)
              Text(
                value.toStringAsFixed(fractionDigits),
              ),
            Expanded(
              child: LayoutBuilder(
                builder: (_, constraints) => Stack(
                  alignment: Alignment.center,
                  children: [
                    if (defaultValue != null)
                      Positioned(
                        left: thumbRadius +
                            (constraints.maxWidth - thumbRadius * 2) *
                                (defaultValue! - min) /
                                (max - min),
                        child: const Marker(),
                      ),
                    Slider(
                      label: value.toStringAsFixed(0),
                      min: min,
                      max: max,
                      value: value,
                      onChanged: onChanged,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
