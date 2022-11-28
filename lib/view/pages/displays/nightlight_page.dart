import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/displays/nightlight_model.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_settings/yaru_settings.dart';

class NightlightPage extends StatelessWidget {
  const NightlightPage({super.key});

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<NightlightModel>(
      create: (_) => NightlightModel(service),
      child: const NightlightPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NightlightModel>();
    return SettingsSection(
      headline: const Text('Nightlight'),
      children: [
        YaruSwitchRow(
          value: model.nightLightEnabled,
          onChanged: model.setNightLightEnabled,
          trailingWidget: const Text('Enable Nightlight'),
        ),
        YaruSliderRow(
          actionLabel: 'Color Temperature',
          min: 1000,
          max: 6500,
          defaultValue: 4000,
          enabled: model.nightLightEnabled ?? false,
          showValue: false,
          value: model.nightLightTemp ?? 4000,
          onChanged: model.setNightLightTemp,
        ),
      ],
    );
  }
}
