import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/touchpad_section.dart';

class MouseAndTouchpadPage extends StatelessWidget {
  const MouseAndTouchpadPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<MouseAndTouchpadModel>(
      create: (_) => MouseAndTouchpadModel(),
      child: const MouseAndTouchpadPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MouseSection(),
        TouchpadSection(),
      ],
    );
  }
}
