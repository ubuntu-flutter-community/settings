import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/date_time_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/date_and_time/date_time_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DateTimeModel(
            dateTimeService: context.read<DateTimeService>(),
            settingsService: context.read<SettingsService>()),
        child: const DateTimePage(),
      );

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.dateAndTimePageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.dateAndTimePageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  @override
  void initState() {
    super.initState();
    final model = context.read<DateTimeModel>();
    model.init();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DateTimeModel>();
    return YaruPage(children: [
      YaruSection(children: [
        YaruSingleInfoRow(
            infoLabel: 'Timezone', infoValue: model.timezone ?? ''),
        YaruSingleInfoRow(
            infoLabel: 'DateTime',
            infoValue: model.dateTime == null ? '' : model.dateTime.toString()),
        YaruSwitchRow(
          trailingWidget: const Text('Auotmatic Timezone'),
          value: model.automaticTimezone,
          onChanged: (v) => model.automaticTimezone = v,
          enabled: model.automaticTimezone != null,
        ),
        YaruSwitchRow(
          trailingWidget: const Text('24h format'),
          value: model.clockIsTwentyFourFormat,
          onChanged: (v) => model.clockIsTwentyFourFormat = v,
          enabled: model.clockIsTwentyFourFormat != null,
        )
      ]),
    ]);
  }
}
