import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/toggle_buttons_setting_row.dart';

class RemovableMediaPage extends StatelessWidget {
  const RemovableMediaPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<RemovableMediaModel>(
      create: (_) => RemovableMediaModel(service),
      child: const RemovableMediaPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RemovableMediaModel>(context);

    return SettingsSection(headline: 'Removable Media', children: [
      SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
          child: CheckboxRow(
              enabled: true,
              value: model.autoRunNever,
              onChanged: (value) => model.autoRunNever = value!,
              text: 'Never ask or start a program for any removable media'),
        ),
      ),
      for (var mimeType in RemovableMediaModel.mimeTypes.entries)
        ToggleButtonsSettingRow(
            actionLabel: mimeType.value,
            labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
            selectedValues: model.getStartup(mimeType.key),
            onPressed: (value) => model.setStartup(value, mimeType.key)),
    ]);
  }
}
