import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    required this.actionLabel,
    required this.secondChild,
  }) : super(key: key);

  final String actionLabel;
  final Widget secondChild;

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
