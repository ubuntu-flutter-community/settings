import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/extra_options_gsettings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class HearingSection extends StatelessWidget {
  const HearingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsSection(
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
    final _model = Provider.of<AccessibilityModel>(context);
    return ExtraOptionsGsettingsRow(
      actionLabel: 'Visual Alerts',
      actionDescription: 'Use a visual indication when an alert sound occurs',
      value: _model.getVisualAlerts,
      onChanged: (value) => _model.setVisualAlerts(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: _model,
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
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Visual Alerts')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        RadioListTile(
          title: const Text('Flash the entire window'),
          value: 'frame-flash',
          groupValue: _model.getVisualAlertsType,
          onChanged: (String? value) => _model.setVisualAlertsType(value!),
        ),
        RadioListTile(
          title: const Text('Flash the entire screen'),
          value: 'fullscreen-flash',
          groupValue: _model.getVisualAlertsType,
          onChanged: (String? value) => _model.setVisualAlertsType(value!),
        ),
      ],
    );
  }
}
