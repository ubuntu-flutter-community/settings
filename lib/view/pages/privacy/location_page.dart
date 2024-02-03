import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/link.dart';
import 'package:settings/view/common/section_description.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/privacy/location_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';

const kPrivacyUrl = 'https://location.services.mozilla.com/privacy';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<LocationModel>(
        create: (_) => LocationModel(getService<SettingsService>()),
        child: const LocationPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LocationModel>();
    return SettingsPage(
      children: [
        SectionDescription(
          width: kDefaultWidth,
          text: context.l10n.locationDescription,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: kDefaultWidth,
            child: Row(
              children: [
                Text(
                  context.l10n.locationInfoPrefix,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 5,
                ),
                Link(url: kPrivacyUrl, linkText: context.l10n.locationInfoLink),
              ],
            ),
          ),
        ),
        SettingsSection(
          width: kDefaultWidth,
          children: [
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.locationActionLabel),
              value: model.enabled,
              onChanged: (v) => model.enabled = v,
            ),
          ],
        ),
      ],
    );
  }
}
