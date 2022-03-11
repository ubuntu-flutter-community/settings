import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';
import 'package:settings/view/pages/displays/displays_model.dart';
import 'package:settings/view/pages/displays/enums/displays_page_section.dart';
import 'package:settings/view/pages/displays/widgets/monitor_section.dart';
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

  @override
  State<DisplaysPage> createState() => _DisplaysPageState();
}

class _DisplaysPageState extends State<DisplaysPage> {
  late DisplaysPageSection _selectedSection;

  @override
  void initState() {
    super.initState();

    _selectedSection = DisplaysPageSection.displays;
  }

  void _switchToSection(DisplaysPageSection section) {
    setState(() {
      _selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DisplaysModel>();

    return ValueListenableBuilder<DisplaysConfiguration?>(
        valueListenable: model.configuration,
        builder: (BuildContext context, DisplaysConfiguration? configurations, _) {
          return YaruPage(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      Widget buttons;
                      if (model.modifyMode) {
                        buttons = Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlinedButton(
                                onPressed: model.apply,
                                child: Text(context.l10n.apply)),
                          ],
                        );
                      } else {
                        buttons = YaruToggleButtonsRow(
                          actionLabel: '',

                          /// top right buttons labels
                          labels: DisplaysPageSection.values
                              .map((e) => e.name(context))
                              .toList(),
                          selectedValues: DisplaysPageSection.values
                              .map((e) => e == _selectedSection)
                              .toList(),

                          /// when press on a button, change view by changing
                          /// selected value
                          onPressed: (index) => _switchToSection(
                              DisplaysPageSection.values[index]),
                        );
                      }

                      return SizedBox(
                        height: 60,
                        child: buttons,
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 4,
                  ),
                  Builder(
                    builder: (context) {
                      switch (_selectedSection) {
                        case DisplaysPageSection.displays:
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: configurations?.configurations.length ?? 0,
                            itemBuilder: (context, index) => MonitorSection(
                              index: index,
                            ),
                          );
                        case DisplaysPageSection.night:
                          return Center(
                            child: Text(context.l10n.nightMode),
                          );
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}
