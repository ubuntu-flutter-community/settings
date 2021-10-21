import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    required this.trailingWidget,
    this.description,
    required this.actionWidget,
  }) : super(key: key);

  final Widget trailingWidget;
  final String? description;
  final Widget actionWidget;

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
                  trailingWidget,
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        description!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                ],
              ),
            ),
            actionWidget,
          ],
        ),
      ),
    );
  }
}
