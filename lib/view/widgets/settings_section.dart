import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class SettingsSection extends StatelessWidget {
  final String headline;
  final List<Widget> children;
  final String schemaId;

  const SettingsSection(
      {Key? key,
      required this.headline,
      required this.children,
      required this.schemaId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _schemaId = 'org.gnome.shell.extensions.dash-to-dock';

    if (GSettingsSchema.lookup(_schemaId) == null) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Schema not installed' + _schemaId),
            ],
          ),
        )
      ]);
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headline,
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        Column(children: children)
      ]),
    );
  }
}
