import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';
import 'package:settings/view/pages/displays/displays_model.dart';
import 'package:settings/view/pages/displays/widgets/monitor_section.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DisplaysPage extends StatefulWidget {
  /// private as we have to pass from create method below
  const DisplaysPage._({Key? key}) : super(key: key);

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.displaysPageTitle);

  static Widget create(BuildContext context) {
    final service = Provider.of<DisplayService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => DisplaysModel(service),
      child: const DisplaysPage._(),
    );
  }

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.displaysPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  State<DisplaysPage> createState() => _DisplaysPageState();
}

class _DisplaysPageState extends State<DisplaysPage> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DisplaysModel>();

    return ValueListenableBuilder<DisplaysConfiguration?>(
        valueListenable: model.configuration,
        builder:
            (BuildContext context, DisplaysConfiguration? configurations, _) {
          return YaruTabbedPage(
            width: kDefaultWidth,
            tabIcons:
                DisplaysPageSection.values.map((e) => e.icon(context)).toList(),
            tabTitles:
                DisplaysPageSection.values.map((e) => e.name(context)).toList(),
            views: DisplaysPageSection.values
                .map((e) => _buildPage(e, model, configurations))
                .toList(),
          );
        });
  }

  Widget _buildPage(
    DisplaysPageSection section,
    DisplaysModel model,
    DisplaysConfiguration? configurations,
  ) {
    switch (section) {
      case DisplaysPageSection.displays:
        return YaruPage(
          children: [
            SizedBox(
              width: kDefaultWidth,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: configurations?.configurations.length ?? 0,
                itemBuilder: (context, index) => MonitorSection(
                  index: index,
                ),
              ),
            ),
          ],
        );
      case DisplaysPageSection.night:
        return YaruPage(
          children: [
            Center(
              child: Text(context.l10n.nightMode),
            )
          ],
        );
      default:
        return Container();
    }
  }
}

enum DisplaysPageSection {
  displays,
  night,
}

extension DisplaysPageSectionExtension on DisplaysPageSection {
  String name(BuildContext context) {
    switch (this) {
      case DisplaysPageSection.displays:
        return context.l10n.displays;
      case DisplaysPageSection.night:
        return context.l10n.nightMode;
      default:
        return '';
    }
  }

  IconData icon(BuildContext context) {
    switch (this) {
      case DisplaysPageSection.displays:
        return YaruIcons.desktop_display;
      case DisplaysPageSection.night:
        return YaruIcons.weather_clear_night;
      default:
        return Icons.check_box_outline_blank;
    }
  }
}
