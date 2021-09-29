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
          selectedValues: model.getStartup(RemovableMediaModel.audioCdda),
          onPressed: (value) =>
              model.setStartup(value, RemovableMediaModel.audioCdda)),
      ToggleButtonsSettingRow(
          actionLabel: 'DVD-Video',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getStartup(RemovableMediaModel.videoDvd),
          onPressed: (value) =>
              model.setStartup(value, RemovableMediaModel.videoDvd)),
      ToggleButtonsSettingRow(
          actionLabel: 'Musicplayer',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getStartup(RemovableMediaModel.audioPlayer),
          onPressed: (value) =>
              model.setStartup(value, RemovableMediaModel.audioPlayer)),
      ToggleButtonsSettingRow(
          actionLabel: 'Photos',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getStartup(RemovableMediaModel.imageDcf),
          onPressed: (value) =>
              model.setStartup(value, RemovableMediaModel.imageDcf)),
      ToggleButtonsSettingRow(
          actionLabel: 'Applications',
          labels: const ['Ignore', 'Open Folder', 'Start App', 'Ask'],
          selectedValues: model.getStartup(RemovableMediaModel.unixSoftware),
          onPressed: (value) =>
              model.setStartup(value, RemovableMediaModel.unixSoftware)),
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
    ]);
  }
}
