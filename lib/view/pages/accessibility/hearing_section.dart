import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class HearingSection extends StatelessWidget {
  const HearingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsSection(
      headline: 'Hearing',
      children: [
        VisualAlerts(),
      ],
    );
  }
}

class VisualAlerts extends StatelessWidget {
  const VisualAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ChangeNotifierProvider.value(
            value: _model,
            child: const _VisualAlertsSettings(),
          ),
        );
      },
      child: SettingsRow(
        actionLabel: 'Visual Alerts',
        secondChild:
            _model.getVisualAlerts ? const Text('On') : const Text('Off'),
      ),
    );
  }
}

class _VisualAlertsSettings extends StatelessWidget {
  const _VisualAlertsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Visual Alerts')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Use a visual indication when an alert sound occurs.'),
        ),
        SettingsRow(
          actionLabel: 'Visual Alerts',
          secondChild: Switch(
            value: _model.getVisualAlerts,
            onChanged: (value) => _model.setVisualAlerts(value),
          ),
        ),
        RadioListTile(
          title: const Text('Flash the entire window'),
          value: 'frame-flash',
          groupValue: _model.getVisualAlertsType,
          onChanged: _model.getVisualAlerts
              ? (String? value) => _model.setVisualAlertsType(value!)
              : null,
        ),
        RadioListTile(
          title: const Text('Flash the entire screen'),
          value: 'fullscreen-flash',
          groupValue: _model.getVisualAlertsType,
          onChanged: _model.getVisualAlerts
              ? (String? value) => _model.setVisualAlertsType(value!)
              : null,
        ),
      ],
    );
  }
}
