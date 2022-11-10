import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/view/pages/power/power_profile_model.dart';
import 'package:settings/view/pages/power/power_profile_widgets.dart';
import 'package:yaru_colors/yaru_colors.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PowerProfileSection extends StatefulWidget {
  const PowerProfileSection({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<PowerProfileModel>(
      create: (_) => PowerProfileModel(context.read<PowerProfileService>()),
      child: const PowerProfileSection(),
    );
  }

  @override
  State<PowerProfileSection> createState() => _PowerProfileSectionState();
}

class _PowerProfileSectionState extends State<PowerProfileSection> {
  @override
  void initState() {
    super.initState();
    context.read<PowerProfileModel>().init();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PowerProfileModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: const Text('Power Mode'),
      children: <Widget>[
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const ProfileModeTitle(
            icon: Icon(
              YaruIcons.meter_5,
              color: YaruColors.error,
            ),
            title: Text('Performance'),
          ),
          subtitle: const Text('High performance and power usage.'),
          value: PowerProfile.performance,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const ProfileModeTitle(
            icon: Icon(YaruIcons.meter_3),
            title: Text('Balanced Power'),
          ),
          subtitle: const Text('Standard performance and power usage.'),
          value: PowerProfile.balanced,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const ProfileModeTitle(
            icon: Icon(
              YaruIcons.meter_1,
              color: YaruColors.success,
            ),
            title: Text('Power save'),
          ),
          subtitle: const Text('Reduced performance and power usage.'),
          value: PowerProfile.powerSaver,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
      ],
    );
  }
}
