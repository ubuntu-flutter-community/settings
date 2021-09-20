import 'package:flutter/material.dart';

import 'settings_row.dart';

class SingleInfoRow extends StatelessWidget {
  final String infoLabel;
  final String infoValue;

  const SingleInfoRow(
      {Key? key, required this.infoLabel, required this.infoValue})
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      actionLabel: infoLabel,
      secondChild: Expanded(
        flex: 2,
        child: SelectableText(
          infoValue,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
          textAlign: TextAlign.right
        )
      )
    );
  }
}
