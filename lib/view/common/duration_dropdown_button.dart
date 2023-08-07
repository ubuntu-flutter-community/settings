import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/utils.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DurationDropdownButton extends StatelessWidget {
  const DurationDropdownButton({
    super.key,
    required this.value,
    required this.values,
    required this.onChanged,
    this.zeroValueText,
  });

  /// The current value of the [DropdownButton]
  final int? value;

  /// The list of values for [DropdownMenuItem] elements
  final List<int> values;

  /// The callback that gets invoked when the [DropdownButton] value changes
  final ValueChanged<int?> onChanged;

  /// Optional string for value 0
  ///
  /// Defaults to 'Never'
  final String? zeroValueText;

  @override
  Widget build(BuildContext context) {
    return YaruPopupMenuButton<int>(
      initialValue: value,
      itemBuilder: (context) {
        return [
          for (final value in values.where((value) => value > 0))
            PopupMenuItem(
              value: value,
              child: Text(formatTime(value)),
              onTap: () => onChanged(value),
            ),
          if (values.contains(0))
            PopupMenuItem(
              value: 0,
              child: Text(zeroValueText ?? context.l10n.never),
            ),
        ];
      },
      child: Text(
        value != null && value != 0
            ? formatTime(value!)
            : zeroValueText ?? context.l10n.never,
      ),
    );
  }
}
