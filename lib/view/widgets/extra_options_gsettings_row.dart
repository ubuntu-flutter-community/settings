import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class ExtraOptionsGsettingsRow extends StatelessWidget {
  const ExtraOptionsGsettingsRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.value,
    required this.onChanged,
    required this.onPressed,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
  final bool? value;
  final Function(bool) onChanged;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final value = this.value;

    if (value == null) {
      return const SizedBox();
    }

    return SettingsRow(
      trailingWidget: Text(actionLabel),
      description: actionDescription,
      actionWidget: Row(
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: onPressed,
              child: const Icon(YaruIcons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
