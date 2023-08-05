import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/view/pages/power/power_profile_model.dart';
import 'package:settings/view/pages/power/power_profile_widgets.dart';
import 'package:settings/view/pages/power/power_profile_x.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PowerProfileSection extends StatefulWidget {
  const PowerProfileSection({super.key});

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
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.powerMode),
      children: [
        for (final profile in PowerProfile.values)
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: ProfileModeTitle(
              powerProfile: profile,
              title: Text(profile.localize(context.l10n)),
            ),
            subtitle: Text(profile.localizeDescription(context.l10n)),
            leading: YaruRadio<PowerProfile?>(
              value: profile,
              groupValue: model.profile,
              onChanged: model.setProfile,
            ),
          ),
      ],
    );
  }
}
