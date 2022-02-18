import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/mouse_and_touchpad/general_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/touchpad_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class MouseAndTouchpadPage extends StatelessWidget {
  const MouseAndTouchpadPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<MouseAndTouchpadModel>(
      create: (_) => MouseAndTouchpadModel(service),
      child: const MouseAndTouchpadPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const YaruPage(
      children: [
        GeneralSection(),
        MouseSection(),
        TouchpadSection(),
      ],
    );
  }
}
