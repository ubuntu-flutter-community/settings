import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HearingSection extends StatelessWidget {
  const HearingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YaruSection(
      width: kDefaultWidth,
      headline: context.l10n.hearing,
      children: const <Widget>[
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
      actionLabel: context.l10n.visualAlerts,
      actionDescription: context.l10n.visualAlertsDescription,
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
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.visualAlerts,
      closeIconData: YaruIcons.window_close,
      children: [
        RadioListTile(
          title: Text(context.l10n.flashEntireWindow),
          value: 'frame-flash',
          groupValue: model.visualAlertsType,
          onChanged: (String? value) => model.setVisualAlertsType(value!),
        ),
        RadioListTile(
          title: Text(context.l10n.flashEntireScreen),
          value: 'fullscreen-flash',
          groupValue: model.visualAlertsType,
          onChanged: (String? value) => model.setVisualAlertsType(value!),
        ),
      ],
    );
  }
}
