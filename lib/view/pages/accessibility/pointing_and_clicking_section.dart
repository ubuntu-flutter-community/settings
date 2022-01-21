import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'package:yaru_icons/yaru_icons.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruSection(
      width: kDefaultWidth,
      headline: 'Pointing & Clicking',
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Mouse Keys'),
          value: model.mouseKeys,
          onChanged: (value) => model.setMouseKeys(value),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Locate Pointer'),
          value: model.locatePointer,
          onChanged: (value) => model.setLocatePointer(value),
        ),
        const _ClickAssist(),
        YaruSliderRow(
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
    final model = context.watch<AccessibilityModel>();
    return YaruRow(
      enabled: model.clickAssistAvailable,
      trailingWidget: const Text('Click Assist'),
      actionWidget: Row(
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
    final model = context.watch<AccessibilityModel>();
    return YaruSimpleDialog(
      width: kDefaultWidth,
      title: 'Click Assist',
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSwitchRow(
          trailingWidget: const Text('Simulated Secondary Click'),
          actionDescription:
              'Trigger a secondary click by holding down the primary button.',
          value: model.simulatedSecondaryClick,
          onChanged: (value) => model.setSimulatedSecondaryClick(value),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: YaruSliderRow(
            enabled: model.simulatedSecondaryClick ?? false,
            actionLabel: 'Delay',
            value: model.secondaryClickTime,
            min: 0.5,
            max: 3.0,
            defaultValue: 1.2,
            fractionDigits: 1,
            onChanged: model.setSecondaryClickTime,
          ),
        ),
        YaruSwitchRow(
          trailingWidget: const Text('Hover Click'),
          actionDescription: 'Trigger a click when the pointer hovers',
          value: model.dwellClick,
          onChanged: (value) => model.setDwellClick(value),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 56,
                child: YaruSliderRow(
                  enabled: model.dwellClick ?? false,
                  actionLabel: 'Delay',
                  value: model.dwellTime,
                  min: 0.2,
                  max: 3.0,
                  defaultValue: 1.2,
                  fractionDigits: 1,
                  onChanged: model.setDwellTime,
                ),
              ),
              SizedBox(
                height: 56,
                child: YaruSliderRow(
                  enabled: model.dwellClick ?? false,
                  actionLabel: 'Motion thresshold',
                  value: model.dwellThreshold,
                  min: 0.0,
                  max: 30.0,
                  defaultValue: 10,
                  onChanged: model.setDwellThreshold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
