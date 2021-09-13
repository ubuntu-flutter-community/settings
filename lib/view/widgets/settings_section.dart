import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.headline,
    required this.children,
    this.schemaId,
  }) : super(key: key);

  final String headline;
  final List<Widget> children;
  final String? schemaId;

  @override
  Widget build(BuildContext context) {
    if (schemaId != null && GSettingsSchema.lookup(schemaId!) == null) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Schema not installed: ' + schemaId!),
              ],
            ),
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  headline,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Column(children: children)
          ],
        ),
      ),
    );
  }
}
