import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String headline;
  final List<Widget> children;

  const SettingsSection(
      {Key? key, required this.headline, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
    ]);
  }
}
