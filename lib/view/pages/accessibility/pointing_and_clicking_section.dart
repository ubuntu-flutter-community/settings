import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/slider_settings_row.dart';
import 'package:settings/view/widgets/slider_settings_secondary.dart';
import 'package:settings/view/widgets/switch_settings_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return SettingsSection(
      headline: 'Pointing & Clicking',
      children: [
        SwitchSettingsRow(
          actionLabel: 'Mouse Keys',
          value: model.getMouseKeys,
          onChanged: (value) => model.setMouseKeys(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Locate Pointer',
          value: model.getLocatePointer,
          onChanged: (value) => model.setLocatePointer(value),
        ),
        const _ClickAssist(),
        SliderSettingsRow(
          actionLabel: 'Double-Click Delay',
          value: model.getDoubleClickDelay,
          min: 100,
          max: 1000,
          onChanged: (value) => model.setDoubleClickDelay(value),
        ),
      ],
    );
  }
}

class _ClickAssist extends StatelessWidget {
  const _ClickAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return SettingsRow(
      actionLabel: 'Click Assist',
      secondChild: Row(
        children: [
          Text(model.getClickAssistString),
          const SizedBox(width: 24.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: model,
                  child: const _ClickAssistSettings(),
                ),
              ),
              child: const Icon(YaruIcons.settings),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClickAssistSettings extends StatelessWidget {
  const _ClickAssistSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccessibilityModel>(context);
    return SimpleDialog(
      title: const Center(child: Text('Click Assist')),
      contentPadding: const EdgeInsets.all(8.0),
      children: [
        SwitchSettingsRow(
          actionLabel: 'Simulated Secondary Click',
          actionDescription:
              'Trigger a secondary click by holding down the primary button.',
          value: model.getSimulatedSecondaryClick,
          onChanged: (value) => model.setSimulatedSecondaryClick(value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SliderSettingsSecondary(
            label: 'Delay',
            enabled: model.getSimulatedSecondaryClick,
            value: model.getSecondaryClickTime,
            min: 0.5,
            max: 3.0,
            onChanged: (value) => model.setSecondaryClickTime(value),
          ),
        ),
        SwitchSettingsRow(
          actionLabel: 'Hover Click',
          actionDescription: 'Trigger a click when the pointer hovers',
          value: model.getDwellClick,
          onChanged: (value) => model.setDwellClick(value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SliderSettingsSecondary(
                label: 'Delay',
                enabled: model.getDwellClick,
                min: 0.2,
                max: 3.0,
                value: model.getDwellTime,
                onChanged: (value) => model.setDwellTime(value),
              ),
              SliderSettingsSecondary(
                label: 'Motion thresshold',
                enabled: model.getDwellClick,
                min: 0.0,
                max: 30.0,
                value: model.getDwellThreshold,
                onChanged: (value) => model.setDwellThreshold(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
