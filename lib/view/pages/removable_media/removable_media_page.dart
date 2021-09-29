import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/toggle_buttons_setting_row.dart';

class RemovableMediaPage extends StatelessWidget {
  const RemovableMediaPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<RemovableMediaModel>(
      create: (_) => RemovableMediaModel(),
      child: const RemovableMediaPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RemovableMediaModel>(context);

    return SettingsSection(headline: 'Removable Media', children: [
      ToggleButtonsSettingRow(
          actionLabel: 'Audio CD',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getAudioStartup,
          onPressed: (value) => model.setAudioStartup = value),
      ToggleButtonsSettingRow(
          actionLabel: 'DVD-Video',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getDvdStartup,
          onPressed: (value) => model.setDvdStartup = value),
      ToggleButtonsSettingRow(
          actionLabel: 'Musicplayer',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getMusicPlayerStartup,
          onPressed: (value) => model.setMusicPlayerStartup = value),
      ToggleButtonsSettingRow(
          actionLabel: 'Photos',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getPhotoViewerStartup,
          onPressed: (value) => model.setPhotoViewerStartup = value),
      ToggleButtonsSettingRow(
          actionLabel: 'Applications',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getAppsStartup,
          onPressed: (value) => model.setAppsStartup = value),
      CheckboxRow(
          enabled: true,
          value: model.autoRunNever,
          onChanged: (value) => model.autoRunNever = value!,
          text: 'Never ask'),
    ]);
  }
}
