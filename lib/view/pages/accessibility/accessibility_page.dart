import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/accessibility/global_section.dart';
import 'package:settings/view/pages/accessibility/hearing_section.dart';
import 'package:settings/view/pages/accessibility/pointing_and_clicking_section.dart';
import 'package:settings/view/pages/accessibility/seeing_section.dart';
import 'package:settings/view/pages/accessibility/typing_section.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<AccessibilityModel>(
      create: (_) => AccessibilityModel(service),
      child: const AccessibilityPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const YaruPage(
      children: [
        GlobalSection(),
        SeeingSection(),
        HearingSection(),
        TypingSection(),
        PointingAndClickingSection(),
      ],
    );
  }
}
