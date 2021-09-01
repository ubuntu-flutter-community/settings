import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Pointing & Clicking',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Mouse Keys',
          value: _model.getMouseKeys,
          onChanged: (value) => _model.setMouseKeys(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Locate Pointer',
          value: _model.getLocatePointer,
          onChanged: (value) => _model.setLocatePointer(value),
        ),
        const _ClickAssist(),
        SettingsRow(
          actionLabel: 'Double-Click Delay',
          secondChild: Expanded(
            child: Slider(
              min: 100,
              max: 1000,
              value: _model.getDoubleClickDelay,
              onChanged: (value) {
                _model.setDoubleClickDelay(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ClickAssist extends StatelessWidget {
  const _ClickAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ChangeNotifierProvider.value(
            value: _model,
            child: const _ClickAssistSettings(),
          ),
        );
      },
      child: SettingsRow(
        actionLabel: 'Click Assist',
        secondChild:
            _model.getClickAssist ? const Text('On') : const Text('Off'),
      ),
    );
  }
}

class _ClickAssistSettings extends StatelessWidget {
  const _ClickAssistSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Click Assist')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SwitchSettingsRow(
          actionLabel: 'Simulated Secondary Click',
          actionDescription:
              'Trigger a secondary click by holding down the primary button.',
          value: _model.getSimulatedSecondaryClick,
          onChanged: (value) => _model.setSimulatedSecondaryClick(value),
        ),
        SettingsRow(
          actionLabel: 'Delay',
          secondChild: Expanded(
            child: Slider(
              min: 0.5,
              max: 3.0,
              value: _model.getSecondaryClickTime,
              onChanged: (value) {
                _model.setSecondaryClickTime(value);
              },
            ),
          ),
        ),
        SwitchSettingsRow(
          actionLabel: 'Hover Click',
          actionDescription: 'Trigger a click when the pointer hovers',
          value: _model.getDwellClick,
          onChanged: (value) => _model.setDwellClick(value),
        ),
        SettingsRow(
          actionLabel: 'Delay',
          secondChild: Expanded(
            child: Slider(
              min: 0.2,
              max: 3.0,
              value: _model.getDwellTime,
              onChanged: (value) {
                _model.setDwellTime(value);
              },
            ),
          ),
        ),
        SettingsRow(
          actionLabel: 'Motion threshold',
          secondChild: Expanded(
            child: Slider(
              min: 0.0,
              max: 30.0,
              value: _model.getDwellThreshold,
              onChanged: (value) {
                _model.setDwellThreshold(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
