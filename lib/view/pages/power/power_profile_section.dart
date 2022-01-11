import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/view/pages/power/power_profile_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PowerProfileSection extends StatefulWidget {
  const PowerProfileSection({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<PowerProfileModel>(
      create: (_) =>
          PowerProfileModel(GetIt.instance.get<PowerProfileService>()),
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
      headline: 'Power Mode',
      children: <Widget>[
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const Text('Performance'),
          subtitle: const Text('High performance and power usage.'),
          value: PowerProfile.performance,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const Text('Balanced Power'),
          subtitle: const Text('Standard performance and power usage.'),
          value: PowerProfile.balanced,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
        RadioListTile<PowerProfile>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const Text('Power Saver'),
          subtitle: const Text('Reduced performance and power usage.'),
          value: PowerProfile.powerSaver,
          groupValue: model.profile,
          onChanged: model.setProfile,
        ),
      ],
    );
  }
}
