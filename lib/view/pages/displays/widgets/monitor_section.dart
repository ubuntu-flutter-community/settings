import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';
import 'package:settings/view/pages/displays/displays_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MonitorSection extends StatelessWidget {
  const MonitorSection({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DisplaysModel>();

    return ValueListenableBuilder<DisplaysConfiguration?>(
      valueListenable: model.configuration,
      builder: (context, value, child) {
        final DisplayMonitorConfiguration config = value!.configurations[index];
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kDefaultWidth),
          child: YaruSection(
            headline: config.name,
            headerWidget: ElevatedButton(
              onPressed: model.modifyMode ? model.apply : null,
              child: Text(context.l10n.apply),
            ),
            //width: kDefaultWidth,
            children: <Widget>[
              /// Orientation row
              YaruRow(
                title: Text(context.l10n.orientation),
                trailing: DropdownButton<LogicalMonitorOrientation>(
                  value: config.transform!,
                  items: [
                    for (final LogicalMonitorOrientation value
                        in model.displayableOrientations)
                      DropdownMenuItem(
                        value: value,
                        child: Text(value.translate(context)),
                      ),
                  ],
                  onChanged: (value) {
                    model.setOrientation(index, value!);
                  },
                ),
              ),

              /// Resolution row
              YaruRow(
                title: Text(context.l10n.resolution),
                trailing: DropdownButton<String>(
                  value: config.resolution,
                  items: [
                    for (final String value in config.availableResolutions)
                      DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ),
                  ],
                  onChanged: (value) => model.setResolution(index, value!),
                ),
              ),

              /// Refresh rate row
              YaruRow(
                title: Text(context.l10n.refreshRate),
                trailing: DropdownButton<String>(
                  value: config.refreshRate,
                  items: [
                    for (final value in config.availableRefreshRates)
                      DropdownMenuItem(
                        value: value,
                        child: Text(
                          double.parse(value).toStringAsFixed(2).toString(),
                        ),
                      ),
                  ],
                  onChanged: (String? value) =>
                      model.setRefreshRate(index, value!),
                ),
              ),

              /// Scale row
              YaruRow(
                title: Text(context.l10n.scale),
                trailing: DropdownButton<int>(
                  value: config.scale!.toInt(),
                  items: [
                    for (final scale in config.availableScales)
                      DropdownMenuItem(
                        value: scale.toInt(),
                        child:
                            Text('x${scale.toString().replaceAll('.0', '')}'),
                      )
                  ],
                  onChanged: (v) => model.setScale(
                    index,
                    config.availableScales[v! - 1],
                  ),
                ),
              ),

              /// Fractional Scaling row
              YaruSwitchRow(
                enabled: false,
                trailingWidget: Text(context.l10n.fractionalScaling),
                actionDescription: context.l10n.fractionalScaling_description,
                onChanged: (bool value) {},
                value: null,
              ),
            ],
          ),
        );
      },
    );
  }
}
