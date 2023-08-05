import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/yaru_slider_row.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PointingAndClickingSection extends StatelessWidget {
  const PointingAndClickingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.pointingAndClicking),
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.mouseKeys),
          value: model.mouseKeys,
          onChanged: model.setMouseKeys,
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.locatePointer),
          value: model.locatePointer,
          onChanged: model.setLocatePointer,
        ),
        const _ClickAssist(),
        YaruSliderRow(
          actionLabel: context.l10n.doubleClickDelay,
          value: model.doubleClickDelay,
          min: 100,
          max: 1000,
          defaultValue: 400,
          onChanged: model.setDoubleClickDelay,
        ),
      ],
    );
  }
}

class _ClickAssist extends StatelessWidget {
  const _ClickAssist();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruTile(
      enabled: model.clickAssistAvailable,
      title: Text(context.l10n.clickAssist),
      trailing: Row(
        children: [
          Text(model.clickAssistString),
          const SizedBox(width: 24.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: model,
                  child: const _ClickAssistSettings(),
                ),
              ),
              child: const Icon(YaruIcons.gear),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClickAssistSettings extends StatelessWidget {
  const _ClickAssistSettings();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.clickAssist,
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.simulatedSecondaryClick),
          actionDescription: context.l10n.simulatedSecondaryClickDescription,
          value: model.simulatedSecondaryClick,
          onChanged: model.setSimulatedSecondaryClick,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: YaruSliderRow(
            enabled: model.simulatedSecondaryClick ?? false,
            actionLabel: context.l10n.delay,
            value: model.secondaryClickTime,
            min: 0.5,
            max: 3.0,
            defaultValue: 1.2,
            fractionDigits: 1,
            onChanged: model.setSecondaryClickTime,
          ),
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.hoverClick),
          actionDescription: context.l10n.hoverClickDescription,
          value: model.dwellClick,
          onChanged: model.setDwellClick,
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
                  actionLabel: context.l10n.delay,
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
                  actionLabel: context.l10n.motionThreshold,
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
