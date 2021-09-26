import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/power/battery_model.dart';
import 'package:settings/view/pages/power/battery_widgets.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:upower/upower.dart';

class BatterySection extends StatefulWidget {
  const BatterySection({Key? key}) : super(key: key);

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
    model.init(context.read<UPowerClient>());
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BatteryModel>();
    return SettingsSection(
      headline: 'Battery',
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(value: model.percentage / 100.0),
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
              Text('${model.percentage.round()}%'),
            ],
          ),
        ),
      ],
    );
  }
}
