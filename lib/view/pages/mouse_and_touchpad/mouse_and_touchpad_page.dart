import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/mouse_and_touchpad/general_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/touchpad_section.dart';

class MouseAndTouchpadPage extends StatelessWidget {
  const MouseAndTouchpadPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = GetIt.instance.get<SettingsService>();
    return ChangeNotifierProvider<MouseAndTouchpadModel>(
      create: (_) => MouseAndTouchpadModel(service),
      child: const MouseAndTouchpadPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        GeneralSection(),
        MouseSection(),
        TouchpadSection(),
      ],
    );
  }
}
