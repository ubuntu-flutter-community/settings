import 'package:flutter/material.dart';
import 'package:settings/services/power_profile_service.dart';

class ProfileModeTitle extends StatelessWidget {
  const ProfileModeTitle({
    Key? key,
    required this.title,
    required this.powerProfile,
  }) : super(key: key);

  final Widget title;
  final PowerProfile powerProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              powerProfile.getIcon(),
              color: powerProfile
                  .getColor(Theme.of(context).brightness == Brightness.light),
            ),
          ),
          title
        ],
      ),
    );
  }
}
