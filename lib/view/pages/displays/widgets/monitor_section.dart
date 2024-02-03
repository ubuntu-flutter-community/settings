import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';
import 'package:settings/view/pages/displays/displays_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MonitorSection extends StatelessWidget {
  const MonitorSection({
    super.key,
    required this.index,
  });

  final int index;

  String _formatRefreshRate(String refreshRate) {
    return double.parse(refreshRate.replaceAll(',', '.'))
        .toStringAsFixed(2)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DisplaysModel>();

    return ValueListenableBuilder<DisplaysConfiguration?>(
      valueListenable: model.configuration,
      builder: (context, value, child) {
        final config = value!.configurations[index];
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kDefaultWidth),
          child: SettingsSection(
            headline: Text(config.name),
            headerWidget: ElevatedButton(
              onPressed: model.modifyMode ? model.apply : null,
              child: Text(context.l10n.apply),
            ),
            //width: kDefaultWidth,
            children: <Widget>[
              /// Orientation row
              YaruTile(
                title: Text(context.l10n.orientation),
                trailing: YaruPopupMenuButton<LogicalMonitorOrientation>(
                  initialValue: config.transform!,
                  itemBuilder: (c) => [
                    for (final value in model.displayableOrientations)
                      PopupMenuItem(
                        value: value,
                        child: Text(value.localize(context)),
                        onTap: () {
                          model.setOrientation(index, value);
                        },
                      ),
                  ],
                  child: Text(
                    config.transform != null
                        ? config.transform!.localize(context)
                        : '',
                  ),
                ),
              ),

              /// Resolution row
              YaruTile(
                title: Text(context.l10n.resolution),
                trailing: YaruPopupMenuButton<String>(
                  initialValue: config.resolution,
                  itemBuilder: (c) => [
                    for (final String value in config.availableResolutions)
                      PopupMenuItem(
                        value: value,
                        onTap: () => model.setResolution(index, value),
                        child: Text(value),
                      ),
                  ],
                  child: Text(config.resolution),
                ),
              ),

              /// Refresh rate row
              YaruTile(
                title: Text(context.l10n.refreshRate),
                trailing: YaruPopupMenuButton<String>(
                  initialValue: config.refreshRate,
                  itemBuilder: (c) => [
                    for (final value in config.availableRefreshRates)
                      PopupMenuItem(
                        value: value,
                        onTap: () => model.setRefreshRate(index, value),
                        child: Text(
                          _formatRefreshRate(value),
                        ),
                      ),
                  ],
                  child: Text(
                    _formatRefreshRate(config.refreshRate),
                  ),
                ),
              ),

              /// Scale row
              YaruTile(
                title: Text(context.l10n.scale),
                trailing: YaruPopupMenuButton<int>(
                  initialValue: config.scale!.toInt(),
                  itemBuilder: (c) => [
                    for (var i = 0; i < config.availableScales.length; i++)
                      PopupMenuItem(
                        value: config.availableScales[i].toInt(),
                        onTap: () {
                          model.setScale(
                            index,
                            config.availableScales[i],
                          );
                        },
                        child: Text(
                          'x${config.availableScales[i].toString().replaceAll('.0', '')}',
                        ),
                      ),
                  ],
                  child:
                      Text('x${config.scale.toString().replaceAll('.0', '')}'),
                ),
              ),

              /// Fractional Scaling row
              YaruSwitchRow(
                enabled: false,
                trailingWidget: Text(context.l10n.fractionalScaling),
                actionDescription: context.l10n.fractionalScaling_description,
                onChanged: (value) {},
                value: null,
              ),
            ],
          ),
        );
      },
    );
  }
}
