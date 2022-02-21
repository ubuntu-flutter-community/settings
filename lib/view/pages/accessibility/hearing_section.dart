import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HearingSection extends StatelessWidget {
  const HearingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YaruSection(
      width: kDefaultWidth,
      headline: 'Hearing',
      children: [
        _VisualAlerts(),
      ],
    );
  }
}

class _VisualAlerts extends StatelessWidget {
  const _VisualAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.settings,
      actionLabel: 'Visual Alerts',
      actionDescription: 'Use a visual indication when an alert sound occurs',
      value: model.visualAlerts,
      onChanged: (value) => model.setVisualAlerts(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: model,
          child: const _VisualAlertsSettings(),
        ),
      ),
    );
  }
}

class _VisualAlertsSettings extends StatelessWidget {
  const _VisualAlertsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Visual Alerts',
      closeIconData: YaruIcons.window_close,
      children: [
        RadioListTile(
          title: const Text('Flash the entire window'),
          value: 'frame-flash',
          groupValue: model.visualAlertsType,
          onChanged: (String? value) => model.setVisualAlertsType(value!),
        ),
        RadioListTile(
          title: const Text('Flash the entire screen'),
          value: 'fullscreen-flash',
          groupValue: model.visualAlertsType,
          onChanged: (String? value) => model.setVisualAlertsType(value!),
        ),
      ],
    );
  }
}
