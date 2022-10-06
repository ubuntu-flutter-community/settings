import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class GlobalSection extends StatelessWidget {
  const GlobalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: context.l10n.global,
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.alwaysShowUniversalAccessMenu),
          value: model.universalAccessStatus,
          onChanged: (value) => model.setUniversalAccessStatus(value),
        ),
      ],
    );
  }
}
