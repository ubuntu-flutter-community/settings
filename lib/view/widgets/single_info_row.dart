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
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: SettingsRow(
        actionLabel: infoLabel,
        secondChild: Text(
          infoValue,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          )
        )
      ),
    );
  }
}
