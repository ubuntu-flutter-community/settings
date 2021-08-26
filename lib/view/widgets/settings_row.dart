import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    required this.actionLabel,
    this.actionDescription,
    required this.secondChild,
  }) : super(key: key);

  final String actionLabel;
  final String? actionDescription;
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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actionLabel,
                  ),
                  if (actionDescription != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        actionDescription!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                ],
              ),
            ),
            secondChild,
          ],
        ),
      ),
    );
  }
}
