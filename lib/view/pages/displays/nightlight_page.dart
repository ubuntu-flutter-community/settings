import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_slider_row.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/displays/nightlight_model.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class NightlightPage extends StatelessWidget {
  const NightlightPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<NightlightModel>(
      create: (_) => NightlightModel(getService<SettingsService>()),
      child: const NightlightPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NightlightModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.nightLightPageTitle),
      children: [
        YaruSwitchRow(
          value: model.nightLightEnabled,
          onChanged: model.setNightLightEnabled,
          trailingWidget: Text(context.l10n.nightLightPageEnableNightlight),
        ),
        YaruSliderRow(
          actionLabel: context.l10n.nightLightPageColorTemprature,
          min: 1000,
          max: 6500,
          defaultValue: 4000,
          enabled: model.nightLightEnabled ?? false,
          showValue: false,
          value: model.nightLightTemp ?? 4000,
          onChanged: model.setNightLightTemp,
        ),
        YaruTile(
          title: Text(context.l10n.nightLightPageScheduleTitle),
          subtitle: Text(context.l10n.nightLightPageScheduleSubtitle),
          enabled: model.nightLightEnabled ?? false,
          trailing: Row(
            children: [
              Text(context.l10n.nightLightPageScheduleFrom),
              const SizedBox(
                width: 10,
              ),
              const TimeSelector(isFrom: true),
              const SizedBox(
                width: 10,
              ),
              Text(context.l10n.nightLightPageScheduleTo),
              const SizedBox(
                width: 10,
              ),
              const TimeSelector(
                isFrom: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key, required this.isFrom});
  final bool isFrom;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NightlightModel>();
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: SpinBox(
            textStyle: const TextStyle(fontSize: 14),
            showCursor: false,
            enableInteractiveSelection: false,
            enabled: model.nightLightEnabled ?? false,
            min: 0,
            max: 23,
            value: model.getNightLightSchedule(isFrom: isFrom).hour.toDouble(),
            direction: Axis.vertical,
            onChanged: (value) => model.setNightLightSchedule(
              value,
              isFrom: isFrom,
              isHours: true,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            ':',
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(
          width: 40,
          child: SpinBox(
            showCursor: false,
            enableInteractiveSelection: false,
            textStyle: const TextStyle(fontSize: 14),
            enabled: model.nightLightEnabled ?? false,
            min: 0,
            max: 59,
            value:
                model.getNightLightSchedule(isFrom: isFrom).minute.toDouble(),
            direction: Axis.vertical,
            onChanged: (value) => model.setNightLightSchedule(
              value,
              isFrom: isFrom,
              isHours: false,
            ),
          ),
        ),
      ],
    );
  }
}
