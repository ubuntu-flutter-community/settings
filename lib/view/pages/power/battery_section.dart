import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/pages/power/battery_model.dart';
import 'package:settings/view/pages/power/battery_widgets.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:upower/upower.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BatterySection extends StatefulWidget {
  const BatterySection({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<BatteryModel>(
      create: (_) => BatteryModel(),
      child: const BatterySection(),
    );
  }

  @override
  State<BatterySection> createState() => _BatterySectionState();
}

class _BatterySectionState extends State<BatterySection> {
  @override
  void initState() {
    super.initState();

    final model = context.read<BatteryModel>();
    model.init(getService<UPowerClient>());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.watch<BatteryModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.batterySectionHeadline),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: YaruLinearProgressIndicator(
            value: model.percentage / 100.0,
            color: model.percentage > 80.0
                ? theme.colorScheme.success
                : model.percentage < 30.0
                    ? theme.colorScheme.error
                    : theme.colorScheme.warning,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BatteryStateLabel(
                state: model.state,
                percentage: model.percentage,
                timeToFull: model.timeToFull,
                timeToEmpty: model.timeToEmpty,
              ),
              Text(context.l10n.batteryPercentage(model.percentage.round())),
            ],
          ),
        ),
      ],
    );
  }
}
