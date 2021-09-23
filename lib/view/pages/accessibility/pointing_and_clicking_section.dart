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
          value: model.mouseKeys,
          onChanged: (value) => model.setMouseKeys(value),
        ),
        SwitchSettingsRow(
          actionLabel: 'Locate Pointer',
          value: model.locatePointer,
          onChanged: (value) => model.setLocatePointer(value),
        ),
        const _ClickAssist(),
        SliderSettingsRow(
          actionLabel: 'Double-Click Delay',
          value: model.doubleClickDelay,
          min: 100,
          max: 1000,
          defaultValue: 400,
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
          Text(model.clickAssistString),
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
          value: model.simulatedSecondaryClick,
          onChanged: (value) => model.setSimulatedSecondaryClick(value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SliderSettingsSecondary(
            label: 'Delay',
            enabled: model.simulatedSecondaryClick,
            value: model.secondaryClickTime,
            min: 0.5,
            max: 3.0,
            defaultValue: 1.2,
            fractionDigits: 1,
            onChanged: (value) => model.setSecondaryClickTime(value),
          ),
        ),
        SwitchSettingsRow(
          actionLabel: 'Hover Click',
          actionDescription: 'Trigger a click when the pointer hovers',
          value: model.dwellClick,
          onChanged: (value) => model.setDwellClick(value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SliderSettingsSecondary(
                label: 'Delay',
                enabled: model.dwellClick,
                min: 0.2,
                max: 3.0,
                defaultValue: 1.2,
                value: model.dwellTime,
                fractionDigits: 1,
                onChanged: (value) => model.setDwellTime(value),
              ),
              SliderSettingsSecondary(
                label: 'Motion thresshold',
                enabled: model.dwellClick,
                min: 0.0,
                max: 30.0,
                defaultValue: 10,
                value: model.dwellThreshold,
                onChanged: (value) => model.setDwellThreshold(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
