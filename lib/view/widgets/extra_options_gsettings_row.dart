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
  final bool value;
  final Function(bool) onChanged;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      actionLabel: actionLabel,
      actionDescription: actionDescription,
      secondChild: Row(
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
