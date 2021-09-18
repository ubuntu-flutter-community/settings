import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String value;

  const InfoText(this.value,
    {Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(
        value,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        ),
        textAlign: TextAlign.right
      )
    );
  }
}
