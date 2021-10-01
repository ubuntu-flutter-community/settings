import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class FilePickerRow extends StatelessWidget {
  const FilePickerRow(
      {Key? key,
      this.description,
      required this.label,
      required this.onPressed,
      required this.pickingDescription})
      : super(key: key);

  final String? description;
  final String label;
  final VoidCallback onPressed;
  final String pickingDescription;

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
        actionLabel: label,
        actionDescription: description,
        secondChild: ElevatedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(YaruIcons.image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pickingDescription),
                )
              ],
            )));
  }
}
