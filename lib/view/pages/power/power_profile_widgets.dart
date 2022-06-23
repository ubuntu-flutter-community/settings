import 'package:flutter/material.dart';

class ProfileModeTitle extends StatelessWidget {
  const ProfileModeTitle({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Widget icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: icon,
          ),
          title
        ],
      ),
    );
  }
}
