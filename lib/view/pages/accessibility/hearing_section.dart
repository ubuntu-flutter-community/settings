import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_extra_option_row.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HearingSection extends StatelessWidget {
  const HearingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.hearing),
      children: const <Widget>[
        _VisualAlerts(),
      ],
    );
  }
}

class _VisualAlerts extends StatelessWidget {
  const _VisualAlerts();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.gear,
      actionLabel: context.l10n.visualAlerts,
      actionDescription: context.l10n.visualAlertsDescription,
      value: model.visualAlerts,
      onChanged: model.setVisualAlerts,
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
  const _VisualAlertsSettings();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.visualAlerts,
      closeIconData: YaruIcons.window_close,
      children: [
        ListTile(
          title: Text(context.l10n.flashEntireWindow),
          leading: YaruRadio(
            value: 'frame-flash',
            groupValue: model.visualAlertsType,
            onChanged: (value) => model.setVisualAlertsType(value!),
          ),
        ),
        ListTile(
          title: Text(context.l10n.flashEntireScreen),
          leading: YaruRadio(
            value: 'fullscreen-flash',
            groupValue: model.visualAlertsType,
            onChanged: (value) => model.setVisualAlertsType(value!),
          ),
        ),
      ],
    );
  }
}
