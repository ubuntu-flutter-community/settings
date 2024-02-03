import 'package:flutter/material.dart';
import 'package:linux_datetime_service/linux_datetime.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/date_and_time/date_time_model.dart';
import 'package:settings/view/pages/date_and_time/timezones.dart';
import 'package:settings/view/pages/settings_alert_dialog.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DateTimeModel(
          dateTimeService: getService<DateTimeService>(),
          settingsService: getService<SettingsService>(),
        ),
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
    return SettingsPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: model.automaticDateTime != null &&
                          !model.automaticDateTime!
                      ? () => showDatePicker(
                            context: context,
                            initialDate: model.dateTime ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ).then(model.setDate)
                      : null,
                  child: Text(model.getLocalDateName(context)),
                ),
                TextButton(
                  onPressed: model.automaticTimezone != null &&
                          !model.automaticTimezone!
                      ? () => showDialog(
                            context: context,
                            builder: (context) => ChangeNotifierProvider.value(
                              value: model,
                              child: const _TimezoneSelectDialog(),
                            ),
                          )
                      : null,
                  child: Text(model.timezone),
                ),
              ],
            ),
          ),
        ),
        SettingsSection(
          width: kDefaultWidth,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: TextButton(
                onPressed:
                    model.automaticDateTime != null && !model.automaticDateTime!
                        ? () => showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then(model.setTime)
                        : null,
                child: Text(
                  model.clock,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),
        SettingsSection(
          width: kDefaultWidth,
          children: [
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.dateAndTimePageAutoDateTime),
              value: model.automaticDateTime,
              onChanged: (v) => model.automaticDateTime = v,
              enabled: model.automaticDateTime != null,
            ),
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.dateAndTimePageAutoTimezone),
              value: model.automaticTimezone,
              onChanged: (v) => model.automaticTimezone = v,
              enabled: model.automaticTimezone != null,
            ),
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.dateAndTimePageTwentyFour),
              value: model.clockIsTwentyFourFormat,
              onChanged: (v) => model.clockIsTwentyFourFormat = v,
              enabled: model.clockIsTwentyFourFormat != null,
            ),
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.dateAndTimePageSecondsInPanel),
              value: model.clockShowSeconds,
              onChanged: (v) => model.clockShowSeconds = v,
              enabled: model.clockShowSeconds != null,
            ),
            YaruSwitchRow(
              trailingWidget: Text(context.l10n.dateAndTimePageWeekdayInPanel),
              value: model.clockShowWeekDay,
              onChanged: (v) => model.clockShowWeekDay = v,
              enabled: model.clockShowWeekDay != null,
            ),
            YaruSwitchRow(
              trailingWidget:
                  Text(context.l10n.dateAndTimePageWeekNumberInCalendar),
              value: model.calendarShowWeekNumber,
              onChanged: (v) => model.calendarShowWeekNumber = v,
              enabled: model.calendarShowWeekNumber != null,
            ),
          ],
        ),
      ],
    );
  }
}

class _TimezoneSelectDialog extends StatelessWidget {
  const _TimezoneSelectDialog();

  @override
  Widget build(BuildContext context) {
    final model = context.read<DateTimeModel>();
    return SettingsAlertDialog(
      title: context.l10n.dateAmdTimePageSelectTimezone,
      child: SettingsPage(
        children: [
          for (final timezone in timezones)
            InkWell(
              borderRadius: BorderRadius.circular(6.0),
              onTap: () {
                model.timezone = timezone;
                Navigator.of(context).pop();
              },
              child: YaruTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(timezone),
                ),
                trailing: const Text(''),
              ),
            ),
        ],
      ),
    );
  }
}
