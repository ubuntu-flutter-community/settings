import 'package:flutter/material.dart';
import 'package:settings/view/pages/accessibility/global_section.dart';
import 'package:settings/view/pages/accessibility/hearing_section.dart';
import 'package:settings/view/pages/accessibility/pointing_and_clicking_section.dart';
import 'package:settings/view/pages/accessibility/seeing_section.dart';
import 'package:settings/view/pages/accessibility/typing_section.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        GlobalSection(),
        SeeingSection(),
        HearingSection(),
        TypingSection(),
        PointingAndClickingSection(),
      ],
    );
  }
}
