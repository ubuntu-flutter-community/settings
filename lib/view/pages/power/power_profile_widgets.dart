import 'package:flutter/material.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/view/pages/power/power_profile_x.dart';

class ProfileModeTitle extends StatelessWidget {
  const ProfileModeTitle({
    super.key,
    required this.title,
    required this.powerProfile,
  });

  final Widget title;
  final PowerProfile powerProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              powerProfile.getIcon(),
              color: powerProfile.getColor(theme),
            ),
          ),
          title,
        ],
      ),
    );
  }
}
