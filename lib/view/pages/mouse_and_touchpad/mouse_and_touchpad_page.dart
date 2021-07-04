import 'package:flutter/material.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/touchpad_section.dart';

class MouseAndTouchpadPage extends StatelessWidget {
  const MouseAndTouchpadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      children: const [MouseSection(), TouchpadSection()],
    )));
  }
}
