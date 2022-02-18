import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/privacy/location_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<LocationModel>(
        create: (_) => LocationModel(context.read<SettingsService>()),
        child: const LocationPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LocationModel>();
    return YaruPage(children: [
      YaruSwitchRow(
          width: kDefaultWidth,
          trailingWidget: const Text('Location Services'),
          value: model.enabled,
          onChanged: (v) => model.enabled = v)
    ]);
  }
}
