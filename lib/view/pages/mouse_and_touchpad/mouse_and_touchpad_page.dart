import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/mouse_and_touchpad/general_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_section.dart';
import 'package:settings/view/pages/mouse_and_touchpad/touchpad_section.dart';
import 'package:settings/view/pages/settings_page.dart';
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

  static Widget createTitle(BuildContext context) =>
      YaruPageItemTitle.text(context.l10n.mouseAndTouchPadPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.mouseAndTouchPadPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return const SettingsPage(
      children: [
        GeneralSection(),
        MouseSection(),
        TouchpadSection(),
      ],
    );
  }
}
