import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.headline,
    required this.children,
  }) : super(key: key);

  final String headline;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
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
