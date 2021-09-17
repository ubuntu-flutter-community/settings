import 'package:flutter/material.dart';

class Marker extends StatelessWidget {
  const Marker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Theme.of(context).dividerColor,
    );
  }
}
